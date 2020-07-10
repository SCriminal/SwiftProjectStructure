//
//  GlobalData.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/24.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

var GB_Nav:UINavigationController!

class GlobalData: NSObject {
    static var GB_Key: String? = nil
    static var GB_NoticeView: NoticeView? = {
        let view = NoticeView.init()
        return view
    }()

}
