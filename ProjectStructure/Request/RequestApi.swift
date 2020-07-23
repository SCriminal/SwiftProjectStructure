//
//  RequestApi.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/6.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

enum ENUM_REQUEST_TYPE {
    case ENUM_REQUEST_GET
    case ENUM_REQUEST_POST
    case ENUM_REQUEST_PATCH
    case ENUM_REQUEST_DELETE
    case ENUM_REQUEST_PUT
}

protocol RequestDelegate {
    var isNotShowNoticeView: Bool {
        get
        set
    }
    
    func endRefreshing()
    func showNoResult()
    func protocolWillRequest()
    func protocolDidRequestSuccess()
    func protocolDidRequestFailure(error: String?)
}


extension RequestDelegate {
    func endRefreshing() {}
    func showNoResult() {}
    func protocolWillRequest() {}
    func protocolDidRequestSuccess() {}
    func protocolDidRequestFailure(error: String?){
    }
}

class RequestApi {
    class func getUrl(URL:String!,
                      delegate:RequestDelegate?,
                      parameters:Dictionary<AnyHashable, Any?>?,
                      returnALL:Bool = false,
                      success:((Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?,
                      failure:((String?,AnyObject?)->Void)?){
        self.requestUrl(URL: URL, delegate: delegate, parameters: parameters, returnALL: returnALL, requestType: .ENUM_REQUEST_GET, progressBlock: nil, success: success, failure: failure)
    }
    
    class func putUrl(URL:String!,
                      delegate:RequestDelegate?,
                      parameters:Dictionary<AnyHashable, Any?>?,
                      returnALL:Bool = false,
                      success:((Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?,
                      failure:((String?,AnyObject?)->Void)?){
        self.requestUrl(URL: URL, delegate: delegate, parameters: parameters, returnALL: returnALL, requestType: .ENUM_REQUEST_PUT, progressBlock: nil, success: success, failure: failure)
    }
    
    class func postUrl(URL:String!,
                       delegate:RequestDelegate?,
                       parameters:Dictionary<AnyHashable, Any?>?,
                       returnALL:Bool = false,
                       success:((Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?,
                       failure:((String?,AnyObject?)->Void)?){
        self.requestUrl(URL: URL, delegate: delegate, parameters: parameters, returnALL: returnALL, requestType: .ENUM_REQUEST_POST, progressBlock: nil, success: success, failure: failure)
    }
    
    class func deleteUrl(URL:String!,
                         delegate:RequestDelegate?,
                         parameters:Dictionary<AnyHashable, Any?>?,
                         returnALL:Bool = false,
                         success:((Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?,
                         failure:((String?,AnyObject?)->Void)?){
        self.requestUrl(URL: URL, delegate: delegate, parameters: parameters, returnALL: returnALL, requestType: .ENUM_REQUEST_DELETE, progressBlock: nil, success: success, failure: failure)
    }
    
    class func patchUrl(URL:String!,
                        delegate:RequestDelegate?,
                        parameters:Dictionary<AnyHashable, Any?>?,
                        returnALL:Bool = false,
                        success:((Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?,
                        failure:((String?,AnyObject?)->Void)?){
        self.requestUrl(URL: URL, delegate: delegate, parameters: parameters, returnALL: returnALL, requestType: .ENUM_REQUEST_PATCH, progressBlock: nil, success: success, failure: failure)
    }
    
    class func requestUrl(URL:String!,
                          delegate:RequestDelegate?,
                          parameters:Dictionary<AnyHashable, Any?>?,
                          returnALL:Bool,
                          requestType:ENUM_REQUEST_TYPE,
                          progressBlock:((Progress) -> Void)?,
                          success:((Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?,
                          failure:((String?,AnyObject?)->Void)?) {
        //设置请求头
        let parameters = self.setInitHead(dicParameters: parameters)
        
        //拼接参数
        let URL = self.replaceParameter(dicParameter: parameters, url: URL)
        
        //走回调 隐藏progress
        delegate?.protocolWillRequest()
        
        //选择请求方式
        self.switchRequest(URLString: URL, parameters: parameters as AnyObject, requestType: requestType, progressBlock: progressBlock, success: { (task, responseObject) in
            delegate?.endRefreshing()
            do {
                if responseObject is Data
                {
                    let dicResponse = try JSONSerialization.jsonObject(with: responseObject as! Data, options: [])
                    if let dicResponse = dicResponse as? Dictionary<AnyHashable, AnyObject> {
                        if let code = dicResponse[RESPONSE_CODE] as? Int, code == RESPONSE_CODE_SUCCESS {
                            self.requestSuccessDelegate(delegate: delegate, responseDic: returnALL ? dicResponse : dicResponse[RESPONSE_DATA] as? Dictionary<AnyHashable, Any?>, success: success)
                            return
                        }
                        if let code = dicResponse[RESPONSE_CODE] as? Int, code == RESPONSE_CODE_RELOGIN {
                            delegate?.protocolDidRequestSuccess()
                            GlobalMethod.relogin()
                            return
                        }
                        if returnALL {
                            self.requestSuccessDelegate(delegate: delegate, responseDic: dicResponse, success: success)
                            return
                        }
                        {
                            self.requestFailDelegate(delegate: delegate, strError: dicResponse[RESPONSE_MESSAGE] as? String, errorCode: dicResponse[RESPONSE_CODE] as? String, failure: failure)
                            return
                        }()
                    } else {
                        self.requestFailDelegate(delegate: delegate, strError: "数据类型错误", errorCode: "0", failure: failure)
                    }
                }
            } catch {
                print(error)
                self.requestFailDelegate(delegate: delegate, strError: "数据请求失败", errorCode: "0", failure: failure)
            }
        }) { (task, error) in
            //上拉 下拉 刷新
            delegate?.endRefreshing()
            self.requestFailDelegate(delegate: delegate, strError: "网络连接失败", errorCode: "0", failure: failure)
        }
    }
    
    // MARK: success
    private class func requestSuccessDelegate(delegate:RequestDelegate?, responseDic:Dictionary<AnyHashable,Any?>?, success:((Dictionary<AnyHashable,Any?>?, AnyObject?)->Void)?) {
        //走回调 请求成功
        delegate?.protocolDidRequestSuccess()
        if let success = success {
            success(responseDic,nil)
        }
        delegate?.showNoResult()
    }
    
    // MARK: fail
    private class func requestFailDelegate(delegate:RequestDelegate?, strError: String?, errorCode: String?, failure:((String?,AnyObject?)->Void)?) {
        let _ = delegate?.protocolDidRequestFailure(error: strError)
        if let failure = failure {
            failure(strError, errorCode as AnyObject?)
        }
        delegate?.showNoResult()
    }
    
    // MARK: 选择请求
    private class func switchRequest(URLString:String!, parameters:AnyObject!, requestType:ENUM_REQUEST_TYPE, progressBlock:((Progress) -> Void)?, success:((URLSessionDataTask, Any?) -> Void)?, failure:((URLSessionDataTask?, Error) -> Void)?) {
        switch (requestType) {
        case .ENUM_REQUEST_PUT:
            RequestInstance.sharedInstance.put(URLString, parameters: parameters, success: success, failure: failure)
            break
        case .ENUM_REQUEST_GET:
            RequestInstance.sharedInstance.get(URLString, parameters:parameters, progress:nil, success:success, failure:failure)
            break
        case .ENUM_REQUEST_POST:
            RequestInstance.sharedInstance.post(URLString, parameters:parameters, progress:progressBlock, success:success, failure:failure)
            break
        case .ENUM_REQUEST_PATCH:
            RequestInstance.sharedInstance.patch(URLString, parameters:parameters,  success:success, failure:failure)
            break
        case .ENUM_REQUEST_DELETE:
            RequestInstance.sharedInstance.delete(URLString, parameters:parameters,  success:success, failure:failure)
            break
        }
    }
    
    // MARK: 拼接基础头字符串
    private class func setInitHead(dicParameters : Dictionary<AnyHashable, Any?>?) -> Dictionary<AnyHashable, Any?> {
        var dicParameters = dicParameters ?? [:]
        for strKey in dicParameters.keys {
            if dicParameters[strKey] == nil {
                dicParameters.removeValue(forKey: strKey)
            }
        }
        dicParameters.updateValue(GlobalData.GB_Key, forKey: "token")
        self.fetchSystem()
        return dicParameters
    }
    
    //转化参数
    private class func replaceParameter(dicParameter:Dictionary<AnyHashable,Any?>!, url URL:String!) -> String! {
        var strReturn:String = URL.hasPrefix("http") ? URL : String(format:"%@%@",URL_HEAD,URL)
        strReturn = strReturn.appendUrl(value: GlobalData.GB_Key, key: "token")
        if dicParameter["scope"] != nil {
            strReturn = strReturn.appendUrl(value: ("/(num)"), key: "scope")
        }
        for key in dicParameter.keys {
            if strReturn.range(of: "{\(key)}") != nil {
                strReturn = strReturn.replacingOccurrences(of: "{\(key)}", with: dicParameter[key]?.flattened() ??? "")
            }
        }
        return strReturn
    }
    
    // MARK: 拼接头数据
    private class func fetchSystem() {
        RequestInstance.sharedInstance.configHeader()
    }
    
}

