//
//  TestVC.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/28.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

class TestVC: BaseVC {
    lazy var submitButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(moduleClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("模块", for: .normal)
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
        
        let a: String? = "a"
        print(a ??? "b")
    }
    
    @objc func moduleClick() {
        GB_Nav.pushViewController(ModuleTestVC.init(), animated: true)
    }
}
