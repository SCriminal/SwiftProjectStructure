//
//  FitSize.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/23.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let isIphoneX = (Int)((SCREEN_HEIGHT/SCREEN_WIDTH)*100) == 216
let iphoneXTopInterval = isIphoneX ? CGFloat(24) : 0
let iphoneXBottomInterval = isIphoneX ? CGFloat(34) : 0
let NAVIGATIONBAR_HEIGHT = 64.0 + iphoneXTopInterval
let TABBAR_HEIGHT = 49.0 + iphoneXBottomInterval
let STATUSBAR_HEIGHT = 20.0 + iphoneXTopInterval

func W(_ n:CGFloat) -> CGFloat{
    return n * UIScreen.main.bounds.size.width / 375.0
}
func F(_ n:CGFloat) -> CGFloat{
    let width = UIScreen.main.bounds.size.width
    if width == 320 {
        return n - 1
    }
    if width == 375 {
        return n
    }
    if width == 414 {
        return n + 1
    }
    return n + 2
}


