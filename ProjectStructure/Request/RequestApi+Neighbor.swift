//
//  RequestApi+Neighbor.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/8.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

extension RequestApi {
    
    class func requestLoginWithAccount(account:String, password:String, delegate:RequestDelegate?, success:(( Dictionary<AnyHashable,Any?>?,AnyObject?)->Void)?, failure:((String?,AnyObject?)->Void)?) {
        let dic: [String:Any?] = ["app":"2",
                                      "scene":"3",
                                      "terminalType":3,
                                      "account":account,
                                      "password":password.base64Encode()]
        self.postUrl(URL: "https://api.wsq.hongjiafu.cn/auth/user/login/3", delegate: delegate, parameters: dic, success: { (response, mark) in
            GlobalData.GB_Key = response?["token"] as? String
            print("token:" + (GlobalData.GB_Key ?? ""))
        }, failure: failure)
    }
    
    /*
     
     extension RequestApi {

         /**
          获取验证码
          */
         class func requestSendCodeWithCellPhone(cellPhone:String!, smsType:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["app":"2",
                                   "cellphone":RequestStrKey(cellPhone),
                                   "smsType":NSNumber.dou(smsType),
                                   "scope":1]
             self.postUrl("/resident/smscode", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          登录(手机号自动注册)
          */
         class func requestLoginWithCode(smsCode:String!, cellPhone:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["app":"2",
                                   "scene":"1",
                                   "terminalType":1,
                                   "terminalNumber":RequestStrKey(CloudPushSDK.getDeviceId()),
                                   "cellphone":RequestStrKey(cellPhone),
                                   "smsCode":RequestStrKey(smsCode),
                                   "scope":1]
             self.postUrl("/resident/auth/login/smscode", delegate:delegate, parameters:dic, success:{ (response:NSDictionary,mark:AnyObject!) in
                 GlobalData.sharedInstance().GB_Key = response.stringValueForKey("token")
                 self.requestUserInfoWithScope(0, delegate:delegate, success:{ (response:NSDictionary,mark:AnyObject!) in
                     let model:ModelUser! = ModelUser.modelObjectWithDictionary(response)
                     GlobalData.sharedInstance().GB_UserModel = model
                     GlobalMethod.requestBindDeviceToken()
                     if (success != nil) {
                         success(response,mark)
                     }
                 }, failure:failure)
             },  failure:failure)
         }

         /**
          居民登录(手机号，密码)
          */
        
         /**
          获取忘记密码验证码
          */
         class func requestSendForgetCodeAccount(account:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["app":"2",
                                   "account":RequestStrKey(account),
                                   "scope":1]
             self.postUrl("/auth/smscode", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          忘记密码
          */
         class func requestResetPwdWithAccount(account:String!, password:String!, smsCode:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["app":"2",
                                   "account":RequestStrKey(account),
                                   "password":RequestStrKey(password.base64Encode()),
                                   "smsCode":RequestStrKey(smsCode)
             ]
             self.patchUrl("/auth/password/0", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          每日签到
          */
         class func requestSignDayWithScore(score:Double, description:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["score":NSNumber.dou(score),
                                   "description":RequestStrKey(description),
                                   "channel":1,
                                   "scope":4]
             self.putUrl("/resident/score/day", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          积分数
          */
         class func requestIntegralTotalDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/score", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          操作记录
          */
         class func requestIntegralRecordDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/score/log/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          查询所有省
          */
         class func requestProvinceWithDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/chinaarea/1/list", delegate:delegate, parameters:dic, success:success, failure:failure)
             //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/1/list" delegate:delegate parameters:dic success:success failure:failure];

         }
         /**
          根据区查询所有镇
          */
         class func requestCityWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":4]
             self.getUrl("/resident/chinaarea/2/list/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
             //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];

         }
         /**
          根据市查询所有区
          */
         class func requestAreaWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":4]
             self.getUrl("/resident/chinaarea/3/list/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
             //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];

         }


         /**
          提交申请
          */
         class func requestMerchantSigninWithStorename(storeName:String!, bizNumber:String!, idNumber:String!, realName:String!, bizUrl:String!, idPositiveUrl:String!, idNegativeUrl:String!, contactPhone:String!, regCountyId:Double, regAddr:String!, bizAreaId:Double, bizAddr:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["storeName":RequestStrKey(storeName),
                                   "bizNumber":RequestStrKey(bizNumber),
                                   "idNumber":RequestStrKey(idNumber),
                                   "realName":RequestStrKey(realName),
                                   "bizUrl":RequestStrKey(bizUrl),
                                   "idPositiveUrl":RequestStrKey(idPositiveUrl),
                                   "idNegativeUrl":RequestStrKey(idNegativeUrl),
                                   "contactPhone":RequestStrKey(contactPhone),
                                   "regCountyId":NSNumber.dou(regCountyId),
                                   "regAddr":RequestStrKey(regAddr),
                                   "bizCountryId":3,
                                   "bizAreaId":NSNumber.dou(bizAreaId),
                                   "bizAddr":RequestStrKey(bizAddr),
                                   "scope":4]
             self.postUrl("/resident/store/review", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          重新提交申请
          */
         class func requestMerchantResigninWithStorename(storeName:String!, bizNumber:String!, idNumber:String!, realName:String!, bizUrl:String!, idPositiveUrl:String!, idNegativeUrl:String!, contactPhone:String!, regCountyId:Double, regAddr:String!, bizAreaId:Double, bizAddr:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["storeName":RequestStrKey(storeName),
                                   "bizNumber":RequestStrKey(bizNumber),
                                   "idNumber":RequestStrKey(idNumber),
                                   "realName":RequestStrKey(realName),
                                   "bizUrl":RequestStrKey(bizUrl),
                                   "idPositiveUrl":RequestStrKey(idPositiveUrl),
                                   "idNegativeUrl":RequestStrKey(idNegativeUrl),
                                   "contactPhone":RequestStrKey(contactPhone),
                                   "regCountyId":NSNumber.dou(regCountyId),
                                   "regAddr":RequestStrKey(regAddr),
                                   "bizAreaId":NSNumber.dou(bizAreaId),
                                   "bizAddr":RequestStrKey(bizAddr),
                                   "scope":4]
             self.patchUrl("/resident/store/1_0_6/review", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          提交详情
          */
         class func requestMerchantSiginDetailWithAreaId(areaId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":NSNumber.dou(4),
                                   "areaId":NSNumber.dou(areaId)]
             self.getUrl("/resident/store/review", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          联系咨询
          */
         class func requestMerchantConnectWithContactphone(contactPhone:String!, contact:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["contactPhone":RequestStrKey(contactPhone),
                                   "contact":RequestStrKey(contact),
                                   "scope":4]
             self.postUrl("/resident/store/before", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          我的成员管理
          */
         class func requestMemeberListWithPage(page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":4]
             self.getUrl("/resident/resident/archive/member/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          店铺列表
          */
         class func requestShopListWithScopeid(scopeId:Double, storeName:String!, sortDistance:Double, sortScore:Double, sortAmount:Double, sortAll:Double, lng:Double, lat:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = [
                 "areaId":NSNumber.dou(scopeId),
                 "name":RequestStrKey(storeName),
                 "sortDistance":NSNumber.dou(sortDistance),
                 "sortScore":NSNumber.dou(sortScore),
                 "sortAmount":NSNumber.dou(sortAmount),
                 "sortAll":NSNumber.dou(sortAll),
                 "lng":NSNumber.dou(lng),
                 "lat":NSNumber.dou(lat),
                 "page":NSNumber.dou(page),
                 "count":NSNumber.dou(count),
                 "scope":1]

             self.getUrl("/resident/store/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          店铺详情
          */
         class func requestShopDetailWithId(identity:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":RequestStrKey(identity),
                                   "scope":NSNumber.dou(4)]
             self.getUrl("/resident/store/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          根据经纬度筛选
          */
         class func requestSelectCommunityWithLng(lng:Double, lat:Double, name:String!, scope:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["lng":NSNumber.dou(lng),
                                   "lat":NSNumber.dou(lat),
                                   "name":RequestStrKey(name),
                                   "scope":NSNumber.dou(1),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count)]
             self.getUrl("/resident/estate/list", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          城市列表（首字母）[^/resident/initial/list/total$]
          */
         class func requestCommunityCityListWithName(name:String!, cityId:Double, countyId:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":NSNumber.dou(1),
                                   "name":RequestStrKey(name),
                                   "cityId":NSNumber.dou(cityId),
                                   "countyId":NSNumber.dou(countyId),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count)]
             self.getUrl("/resident/initial/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          列表
          */
         class func requestAddressListWithPage(page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":NSNumber.dou(4)]
             self.getUrl("/resident/shippingaddr/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          删除
          */
         class func requestDeleteAddressWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(4)]
             self.deleteUrl("/resident/shippingaddr/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          新增
          */
         class func requestAddAddressWithCountyid(countyId:Double, detail:String!, contact:String!, contactPhone:String!, lng:String!, lat:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["countyId":NSNumber.dou(countyId),
                                   "addrDetail":RequestStrKey(detail),
                                   "contact":RequestStrKey(contact),
                                   "contactPhone":RequestStrKey(contactPhone),
                                   "lng":RequestStrKey(lng),
                                   "lat":RequestStrKey(lat),
                                   "scope":NSNumber.dou(4)]
             self.postUrl("/resident/shippingaddr", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          编辑
          */
         class func requestEditAddressWithCountyid(countyId:Double, detail:String!, contact:String!, contactPhone:String!, lng:String!, lat:String!, id identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["countyId":NSNumber.dou(countyId),
                                   "addrDetail":RequestStrKey(detail),
                                   "contact":RequestStrKey(contact),
                                   "contactPhone":RequestStrKey(contactPhone),
                                   "lng":RequestStrKey(lng),
                                   "lat":RequestStrKey(lat),
                                   "id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/shippingaddr/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          列表
          */
         class func requestNewsListWithScopeid(scopeId:Double, page:Double, count:Double, categoryAlias:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["areaId":NSNumber.dou(scopeId),
                                   "scopeId":NSNumber.dou(scopeId),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "categoryAlias":RequestStrKey(categoryAlias),
                                   "scope":NSNumber.dou(1)]
             self.getUrl("/resident/content/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          详情
          */
         class func requestNewsDetailWithId(identity:Double, scopeId:Double, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "areaid":NSNumber.dou(scopeId),
                                   "scopeId":NSNumber.dou(scopeId),
                                   "scope":NSNumber.dou(scope)]
             self.getUrl("/resident/content/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          修改
          */
         class func requestEditPersonlInfoWithHeadurl(headUrl:String!, nickname:String!, phone:String!, addr:String!, gender:Double, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["headUrl":RequestStrKey(headUrl),
                                   "nickname":RequestStrKey(nickname),
                                   "phone":RequestStrKey(phone),
                                   "addr":RequestStrKey(addr),
                                   "gender":NSNumber.dou(gender),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/user", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          获取
          */
         class func requestUserInfoWithScope(scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":NSNumber.dou(4)]
             self.getUrl("/resident/user", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          列表
          */
         class func requestArchiveListWithPage(page:Double, count:Double, estateId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "estateId":NSNumber.dou(estateId),
                                   "scope":NSNumber.dou(4)]
             self.getUrl("/resident/resident/archive/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          新增
          */
         class func requestAddArchiveWithEstateid(estateId:Double, cellPhone:String!, buildingName:String!, unitName:String!, roomName:String!, tag:Double, lng:String!, lat:String!, job:String!, enterprise:String!, isPart:Double, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["estateId":NSNumber.dou(estateId),
                                   "cellPhone":RequestStrKey(cellPhone),
                                   "buildingName":RequestStrKey(buildingName),
                                   "unitName":RequestStrKey(unitName),
                                   "roomName":RequestStrKey(roomName),
                                   "tag":NSNumber.dou(tag),
                                   "lng":RequestStrKey(lng),
                                   "lat":RequestStrKey(lat),
                                   "job":RequestStrKey(job),
                                   "enterprise":RequestStrKey(enterprise),
                                   "isParty":NSNumber.dou(isPart),
                                   "scope":NSNumber.dou(4)]
             self.postUrl("/resident/resident/archive", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          编辑
          */
         class func requestEditArchiveWithEstateid(estateId:Double, cellPhone:String!, buildingName:String!, unitName:String!, roomName:String!, tag:Double, lng:String!, lat:String!, job:String!, enterprise:String!, isPart:Double, identity:Double, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["estateId":NSNumber.dou(estateId),
                                   "cellPhone":RequestStrKey(cellPhone),
                                   "buildingName":RequestStrKey(buildingName),
                                   "unitName":RequestStrKey(unitName),
                                   "roomName":RequestStrKey(roomName),
                                   "tag":NSNumber.dou(tag),
                                   "lng":RequestStrKey(lng),
                                   "lat":RequestStrKey(lat),
                                   "job":RequestStrKey(job),
                                   "enterprise":RequestStrKey(enterprise),
                                   "isParty":NSNumber.dou(isPart),
                                   "id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/resident/archive/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          列表
          */
         class func requestIntegralStoreProductListWithScope(scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/score/sku/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          详情(居民))[^/resident/sku/[a-zA-Z0-9_-]{1,64}$
          */
         class func requestProductDetailWithCode(code:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["code":RequestStrKey(code),
                                   "scope":1]
             self.getUrl("/resident/sku/{code}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestIntegralProductDetailWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(4)]
             self.getUrl("/resident/score/sku/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          新增(购买)
          */
         class func requestIntegralProductExchangeWithScoreskuid(scoreSkuId:Double, qty:Double, addrId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["skuId":NSNumber.dou(scoreSkuId),
                                   "qty":NSNumber.dou(qty),
                                   "addrId":NSNumber.dou(addrId),
                                   "scope":NSNumber.dou(4)]
             self.postUrl("/resident/score/order", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          列表
          */
         class func requestShopProductWithscopeId(scopeId:String!, storeId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scopeId":RequestStrKey(scopeId),
                                   "storeId":NSNumber.dou(storeId),
                                   "scope":NSNumber.dou(1)]
             self.getUrl("/resident/sku/category/list/tree", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          列表(广告位组别名查询)
          community 社区
          live 生活
          procurement 采购
          */
         class func requestADListWithGroupalias(groupAlias:String!, scopeId:Double, delegate:RequestDelegate?, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["locationAliases":RequestStrKey(groupAlias),
                                   "areaId":NSNumber.dou(scopeId),
                                   "scopeId":NSNumber.dou(scopeId),
                                   "count":NSNumber.dou(5000),
                                   "scope":NSNumber.dou(1)]
             self.getUrl("/resident/ad/list/location", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          列表
          */
         class func requestWhistleListWithStatus(status:String!, page:Double, count:Double, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["status":RequestStrKey(status),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":4]
             self.getUrl("/resident/whistle/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          居民发哨
          */
         class func requestAddWhistleWithArchiveid(archiveId:Double, whistleTime:NSNumber!, description:String!, url:String!, scope:String!, categoryId:Double, areaId:Double, detailAddr:String!, realName:String!, cellPhone:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["archiveId":NSNumber.dou(archiveId),
                                   "findTime":whistleTime,
                                   "description":RequestStrKey(description),
                                   "urls":RequestStrKey(url),
                                   "categoryId":NSNumber.dou(categoryId),
                                   "areaId":NSNumber.dou(areaId),
                                   "detailAddr":RequestStrKey(detailAddr),
                                   "realName":RequestStrKey(realName),
                                   "cellPhone":RequestStrKey(cellPhone),
                                   "scope":4]
             self.postUrl("/resident/whistle/1", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          评价
          */
         class func requestCommentWhistleWithEvaluation(evaluation:String!, score:Double, id identity:Double, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["evaluation":RequestStrKey(evaluation),
                                   "score":NSNumber.dou(score),
                                   "id":NSNumber.dou(identity),
                                   "scope":4]
             self.putUrl("/resident/whistle/10/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestWhistleDetailWithId(identity:Double, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":4]
             self.getUrl("/resident/whistle/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }


         /**
          版本升级
          */
         class func requestVersionWithDelegate(delegate:RequestDelegate?, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["app":"7",
                                   "terminalType":1,
                                   "versionNumber":GlobalMethod.getVersion()]
             self.getUrl("/resident/version/new", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          医院列表
          */
         class func requestHospitalListWithAreaId(areaId:Double, name:String!, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":1,
                                   "areaId":NSNumber.dou(areaId),
                                   "name":RequestStrKey(name),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count)]
             self.getUrl("/resident/hospital/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          房屋租赁 交易板-上架
          */
         class func requestRentUploadWithId(identity:String!, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":RequestStrKey(identity),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/bizboard/9/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          房屋租赁 交易板-下架
          */
         class func requestRentOutWithId(identity:String!, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":RequestStrKey(identity),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/bizboard/21/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          房屋租赁 交易板-关闭
          */
         class func requestRentCloseWithId(identity:String!, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":RequestStrKey(identity),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/bizboard/99/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          提交
          */
         class func requestRentSubmitWithId(identity:Double, title:String!, coverUrl:String!, description:String!, price:Double, contact:String!, contactPhone:String!, floor:Double, totalFloor:Double, layoutBedroom:Double, layoutParlor:Double, layoutToilet:Double, direction:Double, houseMode:Double, lng:String!, lat:String!, floorage:String!, areaId:Double, displayMode:Double, urls:String!, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "categoryId":NSNumber.dou(1),
                                   "title":RequestStrKey(title),
                                   "coverUrl":RequestStrKey(coverUrl),
                                   "description":RequestStrKey(description),
                                   "price":NSNumber.dou(price),
                                   "contact":RequestStrKey(contact),
                                   "contactPhone":RequestStrKey(contactPhone),
                                   "floor":NSNumber.dou(floor),
                                   "totalFloor":NSNumber.dou(totalFloor),
                                   "layoutBedroom":NSNumber.dou(layoutBedroom),
                                   "layoutParlor":NSNumber.dou(layoutParlor),
                                   "layoutToilet":NSNumber.dou(layoutToilet),
                                   "direction":NSNumber.dou(direction),
                                   "houseMode":NSNumber.dou(houseMode),
                                   "lng":RequestStrKey(lng),
                                   "lat":RequestStrKey(lat),
                                   "floorage":RequestStrKey(floorage),
                                   "areaId":NSNumber.dou(areaId),
                                   "displayMode":NSNumber.dou(displayMode),
                                   "urls":RequestStrKey(urls),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/bizboard/1/9", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestRentDetailWithId(identity:Double, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(4)]
             self.getUrl("/resident/bizboard/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情-发布人
          */
         class func requestRentPersonalDetailWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity)]
             self.getUrl("/resident/biz/board/issuer/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          房屋租赁 交易板列表
          */
         class func requestRentListWithLayoutbedroom(layoutBedroom:Double, areaId:Double, layoutParlor:Double, layoutToilet:Double, direction:Double, houseMode:Double, minPrice:Double, maxPrice:Double, page:Double, count:Double, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["areaId":NSNumber.dou(areaId),
                                   "layoutBedroom":NSNumber.dou(layoutBedroom),
                                   "layoutParlor":NSNumber.dou(layoutParlor),
                                   "layoutToilet":NSNumber.dou(layoutToilet),
                                   "direction":NSNumber.dou(direction),
                                   "houseMode":NSNumber.dou(houseMode),
                                   "minPrice":NSNumber.dou(minPrice),
                                   "maxPrice":NSNumber.dou(maxPrice),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":NSNumber.dou(4)]
             let dicFilter:NSMutableDictionary! = NSMutableDictionary.dictionary()
             for key:String! in dic.allKeys {
                 let value:Double = dic.objectForKey(key).doubleValue()
                 if (value != nil) {
                     dicFilter.setObject(dic.objectForKey(key), forKey:key)
                 }
              }
             self.getUrl("/resident/bizboard/list/total", delegate:delegate, parameters:dicFilter, success:success, failure:failure)
         }
         /**
          房屋租赁 交易板列表(发布人看)
          */
         class func requestRentPersonalListWithCount(count:Double, areaId:Double, scope:Double, page:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["count":NSNumber.dou(count),
                                   "areaId":NSNumber.dou(areaId),
                                   "scope":NSNumber.dou(4),
                                   "page":NSNumber.dou(page)]
             self.getUrl("/resident/bizboard/list/publisher/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          登出
          */
         class func requestLogoutWithDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["app":"2",
                                   "scene":"1",
                                   "scope":4]
             self.deleteUrl("/auth/user/logout/token", delegate:delegate, parameters:dic, success:{ (response:NSDictionary!,mark:AnyObject!) in
                 GlobalMethod.clearUserInfo()
                 GlobalMethod.createRootNav()
                 GB_Nav.pushVCName("LoginViewController", animated:false)
             }, failure: { (errorStr:String!,mark:AnyObject!) in
                 GlobalMethod.clearUserInfo()
                 GlobalMethod.createRootNav()
                 GB_Nav.pushVCName("LoginViewController", animated:false)
             })
         }

         /**
          列表
          */
         class func requestCommunityServiceListWithType(type:Double, count:Double, page:Double, status:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":NSNumber.dou(4),
                                   "type":NSNumber.dou(type),
                                   "count":NSNumber.dou(count),
                                   "page":NSNumber.dou(page),
                                   "statuses":RequestStrKey(status)]
             self.getUrl("/resident/estateservice/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          新增
          */
         class func requestAddCommunityServiceWithArchiveid(archiveId:Double, serviceType type:Double, description:String!, findTime:Double, urls:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["archiveId":NSNumber.dou(archiveId),
                                   "type":NSNumber.lon(type),
                                   "description":RequestStrKey(description),
                                   "findTime":NSNumber.lon(findTime),
                                   "urls":RequestStrKey(urls),
                                   "scope":NSNumber.dou(4)]
             self.postUrl("/resident/estateservice/1", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          评价
          */
         class func requestCommunityServiceCommentWithScore(score:Double, evaluation:String!, id identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["score":NSNumber.dou(score),
                                   "evaluation":RequestStrKey(evaluation),
                                   "id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(4)]
             self.patchUrl("/resident/estateservice/10/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestCommunityServiceDetailWithId(identity:Double, scope:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":NSNumber.dou(scope)]
             self.getUrl("/resident/estateservice/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          详情
          */
         class func requestHelpDetailWithId(identity:Double, areaId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "areaId":NSNumber.dou(areaId),
                                   "scope":4]
             self.getUrl("/resident/lovehelp/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          列表
          */
         class func requestHelpListWithAreaId(areaId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4,
                                   "areaId":NSNumber.dou(areaId)]
             self.getUrl("/resident/lovehelp/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          - 绑定设备
          */
         class func requestBindDeviceIdWithDeviceID(device_id:String!, delegate:RequestDelegate?, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let deviceID:String! = CloudPushSDK.getDeviceId()
             if !isStr(deviceID) {
                 return
             }
             let dic:NSDictionary! = ["app":"2",
                                   "scene":"1",
                                   "type":1,
                                   "scope":4,
                                   "number":deviceID]
             self.patchUrl("/auth/user/terminal/number", delegate:delegate, parameters:dic, success:success, failure:failure)

         }

         /**
          token登录/时效延长
          */
         class func requestExtendTokenSuccess(success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             if !GlobalMethod.isLoginSuccess() {
                 failure("",nil)
                 return
             }
             let dic:NSDictionary! = ["app":"2",
                                   "scope":1,
                                   "scene":"1",
                                   "token":GlobalData.sharedInstance().GB_Key
             ]
             self.postUrl("/auth/user/login/token", delegate:nil, parameters:dic, success:success, failure:failure)
         }
         /**
          报名
          */
         class func requestParticipateActivityWithEventid(eventId:Double, archiveId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["eventId":NSNumber.dou(eventId),
                                   "archiveId":NSNumber.dou(archiveId),
                                   "scope":4]
             self.postUrl("/resident/event/participant", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          列表
          */
         class func requestActivityListWithAreaId(areaId:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4,
                                   "areaId":NSNumber.dou(areaId), "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count)]
             self.getUrl("/resident/event/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestActivityDetailWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":4]
             self.getUrl("/resident/event/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestAssociationDetailWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":4]
             self.getUrl("/resident/team/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          根据位置获取模块
          */
         class func requestModuleWithLocationaliases(locationAliases:String!, areaId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["locationAliases":RequestStrKey(locationAliases),
                                   "areaId":NSNumber.dou(areaId),
                                   "scope":1,
                                   "isIos":1
             ]
             self.getUrl("/resident/module/list/location", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          新增(参与)
          */
         class func requestParticipateQuestionairWithArchiveid(archiveId:Double, content:String!, id identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["archiveId":NSNumber.dou(archiveId),
                                   "content":RequestStrKey(content),
                                   "id":NSNumber.dou(identity),
                                   "scope":4
             ]
             self.postUrl("/resident/questionnaire/participant/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestQuestionairDetailWithId(identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "scope":4]
             self.getUrl("/resident/questionnaire/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          列表
          */
         class func requestQuestionairListWithAreaid(areaId:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["areaId":NSNumber.dou(areaId),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":4]
             self.getUrl("/resident/questionnaire/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          清空
          */
         class func requestClearTrolleyWithDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.deleteUrl("/resident/cart/list", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          修改(数量)
          */
         class func requestChangeTrolleyNumWithId(identity:String!, qty:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["code":RequestStrKey(identity),
                                   "qty":NSNumber.dou(qty),
                                   "scope":4]
             self.patchUrl("/resident/cart/sku/list", delegate:delegate, parameters:dic, success:{ (response:NSDictionary!,mark:AnyObject!) in
                 NSNotificationCenter.defaultCenter().postNotificationName(NOTICE_TROLLEY_EXCHANGE, object:nil)
                 if (success != nil) {
                     success(response,mark)
                 }
             }, failure:failure)
         }
         /**
          新增(加入购物车)
          */
         class func requestAddTrolleyWithId(identity:String!, qty:Double, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["code":RequestStrKey(identity),
                                   "qty":NSNumber.dou(qty),
                                   "scope":4]
             self.postUrl("/resident/cart/sku/list", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          删除商品[^/resident/cart/sku/list$]
          */
         class func requestDeleteTrolleyWithIds(ids:String!, scope:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["codes":RequestStrKey(ids),
                                   "scope":4]
             self.deleteUrl("/resident/cart/sku/list", delegate:delegate, parameters:dic, success:{ (response:NSDictionary!,mark:AnyObject!) in
                 NSNotificationCenter.defaultCenter().postNotificationName(NOTICE_TROLLEY_EXCHANGE, object:nil)
                 if (success != nil) {
                     success(response,mark)
                 }
             }, failure:failure)
         }
         /**
          详情[^/resident/cart/store/list$]
          */
         class func requestTrolleyDetailWithDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/cart/store/list", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          提交
          */
         class func requestAddAuthenticationWithIdnumber(idNumber:String!, realName:String!, idPortrait:String!, idEmblem:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["idNumber":RequestStrKey(idNumber),
                                   "realName":RequestStrKey(realName),
                                   "idPortrait":RequestStrKey(idPortrait),
                                   "idEmblem":RequestStrKey(idEmblem),
                                   "scope":4
             ]
             self.postUrl("/resident/user/review", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          详情
          */
         class func requestAuthenticationDetailWithDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/user/review", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          根据建档信息筛选[^/resident/resident/archive/estate/list$]
          */
         class func requestCommunityListWithArchiveDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4]
             self.getUrl("/resident/resident/archive/estate/list", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          下单
          */
         class func requestSubmitOrderWithSkus(skus:String!, addrId:Double, description:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["skus":RequestStrKey(skus),
                                   "addrId":NSNumber.dou(addrId),
                                   "description":RequestStrKey(description),
                                   "scope":4]
             self.postUrl("/resident/order/1", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          付款
          */
         class func requestPayOrderWithNumbers(numbers:String!, payChannel:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["numbers":RequestStrKey(numbers),
                                   "payChannel":NSNumber.dou(payChannel),
                                   "scope":4]
             self.patchUrl("/resident/order/5", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          取消
          */
         class func requestCancelOrderWithNumbers(numbers:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["numbers":RequestStrKey(numbers),
                                   "scope":4]
             self.patchUrl("/resident/order/99", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          收货
          */
         class func requestReceiveOrderWithNumbers(numbers:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["numbers":RequestStrKey(numbers),
                                   "scope":4]
             self.patchUrl("/resident/order/10", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          列表（买家）
          */
         class func requestOrderListWithStatuses(statuses:String!, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":4,
                                   "statuses":RequestStrKey(statuses)]
             self.getUrl("/resident/order/list/user/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          详情（买家）[^/resident/order/user$]
          */
         class func requestOrderDetailWithNumber(number:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["scope":4,
                                   "number":RequestStrKey(number)]
             self.getUrl("/resident/order/user", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          修改地址[^/resident/order/addr$]
          */
         class func requestRemedyAddressWithAddrid(addrId:Double, numbers:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["addrId":NSNumber.dou(addrId),
                                   "numbers":RequestStrKey(numbers),
                                   "scope":4]
             self.patchUrl("/resident/order/addr", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          列表
          */
         class func requestIntetralOrderListWithId(identity:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                   "page":NSNumber.dou(page),
                                   "count":NSNumber.dou(count),
                                   "scope":4]
             self.getUrl("/resident/score/order/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }


         /**
          支付
          */
         class func requestAliPayWithNumber(number:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["number":RequestStrKey(number),
                                   "scope":NSNumber.dou(4)]
             self.putUrl("/resident/order/pay/ali/1_0_6", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          支付完成
          */
         class func requestAliPaySuccessWithContent(content:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["content":RequestStrKey(content),
                                   "scope":NSNumber.dou(4)]
             self.putUrl("/resident/order/pay/ali/1_0_6/result", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
          支付[^/resident/order/wechat/pay/1_0_6$]
          */
         class func requestWechatPayWithNumber(number:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["number":RequestStrKey(number),
                                   "scope":4]
             self.postUrl("/resident/order/pay/wechat/1_0_6", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
          支付完成[^/resident/order/wechat/pay/1_0_6/finish$]
          */
         class func requestWechatPaySuccessWithNumber(number:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["number":RequestStrKey(number),
                                   "scope":4]
             self.putUrl("/resident/order/pay/wechat/1_0_6/result", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
         列表
         */
         class func requestMsgListWithCategories(categories:String!, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["categories":RequestStrKey(categories),
                                    "page":NSNumber.dou(page),
                                    "count":NSNumber.dou(count),
                                       "scope":4
                 ]
                 self.getUrl("/resident/push/log/1_0_10/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
         /**
         列表
         */
         class func requestCertificateDealCategoryListWithCategoryalias(categoryAlias:String!, areaId:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["categoryAlias":RequestStrKey(categoryAlias),
                                    "areaId":NSNumber.dou(areaId),
                                    "page":NSNumber.dou(page),
                                    "count":NSNumber.dou(count),
                                       "scope":4
                 ]
                 self.getUrl("/resident/onekey/1_0_10/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         详情
         */
         class func requestCertificateContentWithId(identity:Double, areaId:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["id":NSNumber.dou(identity),
                                    "areaId":NSNumber.dou(areaId),
                                       "scope":4
                 ]
                 self.getUrl("/resident/onekey/1_0_10/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         提交
         */
         class func requestSubmitCertificateWithRealname(realName:String!, idNumber:String!, content:String!, areaId:Double, identity:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["realName":RequestStrKey(realName),
                                    "idNumber":RequestStrKey(idNumber),
                                    "content":RequestStrKey(content),
                                    "areaId":NSNumber.dou(areaId),
                                    "id":NSNumber.dou(identity),
                                       "scope":4
                 ]
                 self.postUrl("/resident/onekey/participant/1_0_10/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         重新提交
         */
         class func requestResubmitCertificateWithNumber(number:String!, content:String!, realName:String!, idNumber:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["number":RequestStrKey(number),
                                    "content":RequestStrKey(content),
                                    "realName":RequestStrKey(realName),
                                    "idNumber":RequestStrKey(idNumber),
                                       "scope":4
                 ]
                 self.patchUrl("/resident/onekey/participant/1_0_10", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         列表
         */
         class func requestCertificateDealResultWithStatuses(statuses:String!, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["statuses":RequestStrKey(statuses),
                                    "page":NSNumber.dou(page),
                                    "count":NSNumber.dou(count),
                                       "scope":4
                 ]
                 self.getUrl("/resident/onekey/participant/1_0_10/list/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         详情
         */
         class func requestCertificateDealResultDetailWithNumber(number:String!, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["number":RequestStrKey(number),
                                       "scope":4
                 ]
                 self.getUrl("/resident/onekey/participant/1_0_10/{number}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }


         class func requestWhistleTypeDelegate(delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["count":NSNumber.dou(5000),
                                   "page":NSNumber.dou(1),
                                   "scope":4]
             self.getUrl("/resident/whistle/category/list/1_0_15/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         用户使用[^/resident/module/1_0_18/user$]
         */
         class func requestModuleUseWithId(identity:String!, delegate:RequestDelegate?, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["id":RequestStrKey(identity),
                                    "scope":4]
                 self.postUrl("/resident/module/1_0_18/user/{id}", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         列表-用户使用次数[^/resident/module/list/1_0_18/total$]
         */
         class func requestModuleHotListWithAreaid(areaId:Double, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
             let dic:NSDictionary! = ["areaId":NSNumber.dou(areaId),
             "scope":1,
                "isIos":1,
                "page":RequestLongKey(page),
                                   "count":RequestLongKey(count)]
             self.getUrl("/resident/module/list/1_0_18/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }

         /**
         列表
         */
         class func requestPartyListWithLat(lat:Double, lng:Double, radius:Double, name:String!, page:Double, count:Double, delegate:RequestDelegate!, success:(NSDictionary!,AnyObject!)->Void, failure:(String!,AnyObject!)->Void) {
                 let dic:NSDictionary! = ["lat":NSNumber.dou(lat),
                                    "lng":NSNumber.dou(lng),
         //                           @"radius":NSNumber.dou(radius),
                                    "name":RequestStrKey(name),
                                    "page":NSNumber.dou(page),
                                    "count":NSNumber.dou(count)]
                 self.getUrl("/resident/partyservicecenter/list/1_0_25/total", delegate:delegate, parameters:dic, success:success, failure:failure)
         }
     }
     */
}
