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
        button.setTitle("login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(btnOpenClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("open", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
    lazy var aryDatas: Array<ModelModule> = {
        let ary:Array<ModelModule> = Array()
        return ary
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(BaseNavView.initNavBack(title: "Module"))
        submitButton.leftTop = (0, NAVIGATIONBAR_HEIGHT)
        self.view.addSubview(submitButton)
        openButton.leftTop = (0, submitButton.bottom)
        self.view.addSubview(openButton)
    }
    
    func requestModuleList() {
        RequestApi.requestModuleList(delegate: nil, success: { (response, mark) in
            self.aryDatas = Array<ModelModule>.exchange(response: response?["list"] as Any?, modelClass: ModelModule.self)
            
            GlobalMethod.showAlert("request list success")
        }, failure: nil)
    }
    
    @objc func btnLoginClick() {
        //        RequestApi.requestLogin(account: "15263676100", password: "Hjf2020", delegate: nil, success: { (response, object) in
        RequestApi.requestLogin(account: "15553611112", password: "123456", delegate: nil, success: { (response, object) in
            GlobalMethod.showAlert("login success")
            self.requestModuleList()
        }, failure: {
            (str: String?,error:AnyObject?) in
            print("error:"+(str ?? ""))
        })
    }
    
    @objc func btnOpenClick() {
        for i in 0..<aryDatas.count {
            let item = aryDatas[i]
            if let isOpen = item.isOpen, isOpen == 0 {
                continue
            }
            if let isIos = item.isIos, isIos == 1 {
                if let isUrl = item.isURL, isUrl != 0 {
                    changeValue(index: i, isOpen: false)
                    return
                }
            }
        }
    }
    
    func changeValue(index: Int, isOpen: Bool) {
        aryDatas[index].isIos = isOpen ? 1 : 0
        RequestApi.requestUpdateModel(model: aryDatas[index], delegate: nil, success: { (response, mark) in
            if isOpen {
                self.btnOpenClick()
            } else {
                self.btnCloseClick()
            }
        }, failure: nil)
    }
    
    @objc func btnCloseClick() {
        
    }
}
