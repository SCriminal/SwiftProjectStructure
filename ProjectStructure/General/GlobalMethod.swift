//
//  GlobalMethod.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/24.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

class GlobalMethod {
    static func canLeftSlide() -> Bool{
        if (GB_Nav.viewControllers.count <= 1) {
            return false
        }
        let lastVC = GB_Nav.viewControllers.last
        return lastVC?.isSlideLeftValid ?? false;
    }
    
    static func relogin() {
        #warning("proceed")
    }
    
    static func showAlert(_ alert:String?) {
        let window = UIApplication.shared.keyWindow
        GlobalData.GB_NoticeView?.show(notice:alert, time: 1, frame: UIScreen.main.bounds, viewShow: window)
    }
   
}
