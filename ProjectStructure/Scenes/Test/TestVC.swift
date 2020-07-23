//
//  TestVC.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/28.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
/*
 */
class TestVC: BaseVC {
    lazy var modelButton: UIButton = {
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
    
    lazy var JavaButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(javaClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("Java", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
    lazy var csvButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(csvClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("csv", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(BaseNavView.initNavBack(title: "Test"))
        modelButton.leftTop = (0, NAVIGATIONBAR_HEIGHT)
        self.view.addSubview(modelButton)
        JavaButton.leftTop = (0, modelButton.bottom)
        self.view.addSubview(JavaButton)
        csvButton.leftTop = (0, JavaButton.bottom)
        self.view.addSubview(csvButton)


    }
    
    @objc func moduleClick() {
        GB_Nav.pushViewController(ModuleTestVC.init(), animated: true)
    }
    @objc func javaClick() {
        GB_Nav.pushViewController(JavaTestVC.init(), animated: true)
    }
    @objc func csvClick() {
        GB_Nav.pushViewController(CSVParseVC.init(), animated: true)
    }
}
