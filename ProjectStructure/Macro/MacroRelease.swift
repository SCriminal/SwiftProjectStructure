//
//  MacroRelease.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/7.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

//请求URL
#if DEBUG

let URL_HEAD =  "http://112.253.1.72:10231"
let URL_IMAGE = "http://112.253.1.72:10299"//image
//let URL_HEAD =  "https://api.wsq.hongjiafu.cn"
//let URL_IMAGE = "https://file.wsq.hongjiafu.cn"//image
let URL_SHARE = "http://172.16.1.102:30001"

#else

let URL_HEAD =  "https://api.wsq.hongjiafu.cn"//外网
let URL_IMAGE = "https://file.wsq.hongjiafu.cn"//阿里云
let URL_SHARE = "https://www.zhongcheyun.cn"//

#endif

#if DEBUG

let SLD_TEST = true //sld_test

#else

let SLD_TEST = false

#endif

//微信 appid
let WXAPPID = "wx6b2248eb6d421951"

//高德地图
let MAPID = "42b54b3ba032ebe76ecf440a69996b47"
