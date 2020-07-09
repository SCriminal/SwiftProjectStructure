//
//  ModuleTestVC.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/9.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

class ModuleTestVC: BaseVC {
    lazy var submitButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(btnLoginClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("登录", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(BaseNavView.initNavBack(title: "Test"))
        submitButton.leftTop = (0, NAVIGATIONBAR_HEIGHT)
        self.view.addSubview(submitButton)
//        test()
    }
    
    

    
    func test() {
        var dic: [AnyHashable: Any?] = [:]
        dic.updateValue("1", forKey: "str")
        dic.updateValue(nil, forKey: "double")
        
        for item in dic.keys {
            print("key:"+"\(item)")
            print("value:"+"\((dic[item]) ?? "")")

        }
    }
    
    
    @objc func btnLoginClick() {
        RequestApi.requestLoginWithAccount(account: "15263676100", password: "Hjf2020", delegate: nil, success: { (response, object) in
               }, failure: nil)
    }
    
    @objc func closeModuleClick() {
        
    }
}
