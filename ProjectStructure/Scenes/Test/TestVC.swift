//
//  TestVC.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/28.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

class TestVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(BaseNavView.initNavBack(title: "Test"))
    }
}
