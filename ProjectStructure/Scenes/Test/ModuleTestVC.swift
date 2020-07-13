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
    
    lazy var closeButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(btnCloseClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("close", for: .normal)
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
        closeButton.leftTop = (0, openButton.bottom)
        self.view.addSubview(closeButton)
        
    }
    
    func requestModuleList() {
        RequestApi.requestModuleList(delegate: nil, success: { (response, mark) in
            self.aryDatas = Array<ModelModule>.exchange(response: response?["list"] as Any?, modelClass: ModelModule.self)
            
            GlobalMethod.showAlert("request list success")
        }, failure: nil)
    }
    
    @objc func btnLoginClick() {
        //        RequestApi.requestLogin(account: "15263676100", password: "Hjf2020", delegate: nil, success: { (response, object) in
        let account = URL_HEAD.hasPrefix("https") ? "15263676100" : "15553611112"
        let pwd = URL_HEAD.hasPrefix("https") ? "Hjf2020" : "123456"
        RequestApi.requestLogin(account: account, password: pwd, delegate: nil, success: { (response, object) in
            GlobalMethod.showAlert("login success")
            self.requestModuleList()
        }, failure: {
            (str: String?,error:AnyObject?) in
            print("error:"+(str ?? ""))
        })
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
        for i in 0..<aryDatas.count {
            let item = aryDatas[i]
            if let isOpen = item.isOpen, isOpen == 0 {
                continue
            }
            if let isIos = item.isIos, isIos == 0 {
                continue
            }
            if let goMode = item.goMode, goMode == 3, let ios = item.ios, ios.count > 0, !ios.hasPrefix("Invoke"), !ios.hasPrefix("SafetyIndexDetailVC") {
                continue
            } else {
                changeValue(index: i, isOpen: false)
                return
            }
        }
    }
    @objc func btnOpenClick() {
        for i in 0..<aryDatas.count {
            let item = aryDatas[i]
            if let isOpen = item.isOpen, isOpen == 0 {
                continue
            }
            if let isIos = item.isIos, isIos == 1 {
                continue
            }
            if let isIos = item.isIos, isIos == 0 {
                changeValue(index: i, isOpen: true)
                return
            }
        }
    }
}
