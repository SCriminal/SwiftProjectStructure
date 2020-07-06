//
//  ProjectInfo.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/6.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

class ProjectInfo: NSObject {
    
    ///获取版本
    class func getVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    
}
