//
//  RequestInstance.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/6.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

let RESPONSE_DATA = "data"//网络请求datas
let RESPONSE_MESSAGE = "msg"//网络请求message
let RESPONSE_CODE = "code"//网络请求提示码


let RESPONSE_CODE_SUCCESS = 0//成功
let RESPONSE_CODE_RELOGIN = 1000//重新登陆

let TIME_REQUEST_OUT = 8

class RequestInstance: AFHTTPSessionManager {
    static let dicConstant: [String: Any?] = {
        var dicExt: [String: Any?] = [:]
        
        let scale_screen = UIScreen.main.scale
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let infoDictionary = Bundle.main.infoDictionary
        dicExt.updateValue(UIDevice.current.systemVersion, forKey: "deploymentTarget")
        dicExt.updateValue(UIDevice.current.identifierForVendor?.uuidString, forKey: "uuid")
        dicExt.updateValue(UIDevice.current.name, forKey: "systemName")
        dicExt.updateValue(UIDevice.current.systemVersion, forKey: "systemVersion")
        dicExt.updateValue(width, forKey: "boundsWidth")
        dicExt.updateValue(height, forKey: "boundsHeight")
        dicExt.updateValue(DeviceInfo.getDeviceSupplier(), forKey: "carrierName")
        dicExt.updateValue(width*scale_screen, forKey: "scaleWidth")
        dicExt.updateValue(height*scale_screen, forKey: "scaleHeight")
        dicExt.updateValue(infoDictionary?["CFBundleVersion"], forKey: "build")
        dicExt.updateValue(infoDictionary?["CFBundleShortVersionString"], forKey: "version")
        dicExt.updateValue(infoDictionary?["CFBundleDisplayName"], forKey: "displayName")
        dicExt.updateValue(infoDictionary?["CFBundleIdentifier"], forKey: "bundleId")
        dicExt.updateValue(UIDevice.current.model, forKey: "iphoneModel")
        return dicExt
    }()
    
    public static let sharedInstance: RequestInstance = {
        let instance = RequestInstance.init()
        instance.responseSerializer = AFHTTPResponseSerializer.init()
        instance.requestSerializer.timeoutInterval = TimeInterval(TIME_REQUEST_OUT)
        instance.configHeader()
        //ignore security
        instance.securityPolicy.allowInvalidCertificates = true
        //是否在证书域字段中验证域名
        instance.securityPolicy.validatesDomainName = false
        return instance
    }()
    
    func configHeader() {
        do {
            let data = try JSONSerialization.data(withJSONObject: RequestInstance.dicConstant , options: [])
            let strExt = String.init(data: data, encoding: .utf8)
            let agent = String.init(format: "hjf/%@(iOS %@;Scale/%.2f)", ProjectInfo.getVersion(), DeviceInfo.getDeviceSystemVersion(), UIScreen.main.scale)
            self.requestSerializer.setValue(agent, forHTTPHeaderField: "User-Agent")
            self.requestSerializer.setValue("4", forHTTPHeaderField: "Source")
            if let strExt = strExt {
                self.requestSerializer.setValue(strExt.base64Encode(), forHTTPHeaderField: "Ext")
            }
        } catch {
            print(error)
        }
    }
    
}
