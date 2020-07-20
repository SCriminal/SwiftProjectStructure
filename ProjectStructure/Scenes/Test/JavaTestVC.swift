//
//  JavaTestVC.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/17.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

class JavaTestVC: BaseVC {
    lazy var submitButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(btnLoginClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("list", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
  lazy var addHero: UIButton = {
      let button = UIButton.init(type: .custom)
      button.tag = 1
      button.addTarget(self, action: #selector(addHeroClick), for: .touchUpInside)
      button.backgroundColor = .gray
      button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
      button.setTitle("Add Hero", for: .normal)
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
        addHero.leftTop = (0, submitButton.bottom)
      self.view.addSubview(addHero)

        
    }
    
   
    
    @objc func btnLoginClick() {
        RequestApi.getUrl(URL: "http://localhost:8080/json", delegate: self, parameters: nil, returnALL:true, success: { (response, object) in
            print("sld success")
            print(response)

        }) { (str, error) in
            print("sld fail")
        }
    }
    
    @objc func addHeroClick() {
        let dic = ["id":116,"name":"1515","hp":100,"damage":50] as [String : Any];
        var strJson: String? = nil
        do {
            let data = try JSONSerialization.data(withJSONObject: dic, options: [])
            strJson = String.init(data: data, encoding: .utf8)
        }catch{
            
        }
        RequestApi.postUrl(URL: "http://localhost:8080/addHero", delegate: self, parameters: ["data": strJson], success: { (response, object) in
            print("sld success")
            print(response)

        }) { (str, error) in
            print("sld fail")
        }
    }
    
   
}
