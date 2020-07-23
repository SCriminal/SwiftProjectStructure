//
//  MacroLocal.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/1.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

//颜色
let COLOR_LINE = UIColor.init(hexString: "f1f1f1")
let COLOR_MAIN = UIColor.init(hexString: "353D55")
let COLOR_DARK = UIColor.init(hexString: "485572")
let COLOR_TITLE = UIColor.init(hexString: "4b4f63")
let COLOR_SUBTITLE = UIColor.init(hexString: "7172736")
let COLOR_BACKGROUND = UIColor.white
let COLOR_999 = UIColor.init(hexString: "999999")
let COLOR_666 = UIColor.init(hexString: "666666")
let COLOR_333 = UIColor.init(hexString: "333333")
let COLOR_BLUE = UIColor.init(hexString: "00B2FF")
let COLOR_RED = UIColor.init(hexString: "FF0000")
let COLOR_YELLOW = UIColor.init(hexString: "FFE13B")
let COLOR_GRAY = UIColor.init(hexString: "#F7F8F9")
let COLOR_ORANGE = UIColor.init(hexString: "#FFA900")
let COLOR_GREEN = UIColor.init(hexString: "#66CC00")

//透明度
let COLOR_BLACK_ALPHA_PER60 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
let COLOR_BLACK_ALPHA_PER90 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)

//map放大倍数
let MAPZOOMNUM = 14.076151

//image name
let IMAGE_HEAD_DEFAULT = "personal_head"
let IMAGE_HEAD_COMPANY_DEFAULT = "company_logo"//use in company info
let IMAGE_BIG_DEFAULT = "image_default"//user for image in detail

//time formatter
let TIME_MONTH_SHOW = "yyyy-MM"
let TIME_DAY_SHOW = "yyyy-MM-dd"
let TIME_HOUR_SHOW = "yyyy-MM-dd HH"
let TIME_MIN_SHOW = "yyyy-MM-dd HH:mm"
let TIME_SEC_SHOW = "yyyy-MM-dd HH:mm:ss"
let TIME_MONTH_DAY_SHOW = "MM-dd"

let TIME_MONTH_CN = "yyyy年MM月"
let TIME_DAY_CN = "yyyy年MM月dd日"
let TIME_HOUR_CN = "yyyy年MM月dd日 HH"
let TIME_MIN_CN = "yyyy年MM月dd日 HH:mm"
let TIME_SEC_CN = "yyyy年MM月dd HH:mm:ss"
let TIME_MONTH_DAY_CN = "MM月dd日"
let TIME_HOUR_MIN_CN = "HH:mm"

//local key
let LOCAL_KEY = "LOCAL_KEY"//本地存储用户key值
let LOCAL_USERMODEL = "LOCAL_USERMODEL"//本地存储用户信息
let LOCAL_COMPANYMODEL = "LOCAL_COMPANYMODEL"//本地存储公司信息
let LOCAL_ENTER_BACK_GROUND = "LOCAL_ENTER_BACK_GROUND"//进入后台时间
let LOCAL_PHONE = "LOCAL_PHONE"//本地存储最后一个手机号
let LOCAL_SHOWED_GUIDE_BEFORE = "LOCAL_SHOWED_GUIDE_BEFORE"//显示引导页
let LOCAL_LOCATION = "LOCAL_LOCATION"//最新定位地址
let LOCAL_PROVINCE_LIST = "LOCAL_PROVINCE_LIST"//获取省
let LOCAL_TROLLEY = "LOCAL_TROLLEY"//购物车
let LOCAL_KEY_HEAD = "LOCAL_LD_"

//通知
let NOTICE_SELFMODEL_CHANGE = "NOTICE_SELFMODEL_CHANGE"//个人信息更改
let NOTICE_LOCATION_CHANGE = "NOTICE_LOCATION_CHANGE"//个人地理位置更改
let NOTICE_ORDER_REFERSH = "NOTICE_ORDER_REFERSH"//订单修改
let NOTICE_MSG_REFERSH = "NOTICE_MSG_REFERSH"//消息
let NOTICE_COMMUNITY_REFERSH = "NOTICE_COMMUNITY_REFERSH"//
let NOTICE_ARCHIVE_CREATE = "NOTICE_ARCHIVE_CREATE"//
let NOTICE_TROLLEY_EXCHANGE = "NOTICE_TROLLEY_EXCHANGE"//
let NOTICE_ALI_PAY_SUCCESS = "NOTICE_ALI_PAY_SUCCESS"//
let NOTICE_WECHAT_PAY_SUCCESS = "NOTICE_WECHAT_PAY_SUCCESS"//


let TAG_LINE = 371
