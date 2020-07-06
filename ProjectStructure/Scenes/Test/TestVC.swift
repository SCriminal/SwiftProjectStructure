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
        request()
    }
    
    
    func request() {
        RequestInstance.sharedInstance.get("http://112.253.1.72:10231/resident/chinaarea/1/list", parameters: ["scope":"4"], progress: nil, success: { (task, data) in
            let response = String.init(data: data as? Data ?? Data(), encoding: .utf8)
        print(data)
        }, failure: nil)
        
        
    }
}
