//
//  BaseNavView.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/28.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

let BASENAVVIEW_LEFT_TITLE_FONT_NUM = F(15)

class BaseNavView: UIView {
    // MARK:property
    lazy var title: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: F(20), weight: .regular)
        label.backgroundColor = .clear
        label.numberOfLines = 1
        return label
    }()
    lazy var backBtn: UIControl = {
        let control = UIControl()
        control.backgroundColor = .clear
        control.addTarget(self, action: #selector(btnBackClick), for: .touchUpInside)
        BaseNavView.resetControl(control, "back_black",  CGSize.init(width: W(25), height: W(25)), true)
        return control
    }()
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = COLOR_LINE
        view.frame = CGRect.init(x: 0, y: NAVIGATIONBAR_HEIGHT-1, width: SCREEN_WIDTH, height: 1)
        return view
    }()
    var leftView: UIView?
    var rightView: UIView?
    var leftBlock: (()->())?
    var rightBlock: (()->())?
    var blockBack: (()->())?
    // MARK:init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("sld init with corder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: NAVIGATIONBAR_HEIGHT)
        self.addSubview(self.title)
        self.addSubview(self.line)
    }
    
    static func initNav(title: String?,
                        leftImageName:String?,
                        _ leftImageSize: CGSize?,
                        _ leftBlock: (()->())?,
                        rightImageName:String?,
                        _ rightImageSize: CGSize?,
                        _ rightBlock: (()->())?) -> BaseNavView {
        let nav = BaseNavView()
        nav.reset(leftImageName: leftImageName, leftImageSize, leftBlock)
        nav.reset(rightImageName: rightImageName, rightImageSize, rightBlock)
        nav.reset(title: title)
        return nav
    }
    
    static func initNavBack(title: String?,
                            rightImageName:String?,
                            rightImageSize: CGSize?,
                            rightBlock: (()->())?) -> BaseNavView {
        let nav = BaseNavView()
        nav.reset(leftView: nav.backBtn)
        nav.reset(rightImageName: rightImageName, rightImageSize, rightBlock)
        nav.reset(title: title)
        return nav
    }
    
    static func initNavBack(title: String?,
                            rightTitle:String?,
                            rightBlock: (()->())?) -> BaseNavView {
        let nav = BaseNavView()
        nav.reset(leftView: nav.backBtn)
        nav.reset(rightTitle: rightTitle, rightBlock)
        nav.reset(title: title)
        return nav
    }
        
    static func initNav(title:String,
                        leftView:UIView?,
                        rightView:UIView?) -> BaseNavView{
        let nav = BaseNavView()
        nav.reset(leftView: leftView)
        nav.reset(rightView: rightView)
        nav.reset(title: title)
        return nav
    }
    
    static func initNavBack(title: String?, rightView: UIView? = nil) -> BaseNavView {
        let nav = BaseNavView()
        nav.reset(leftView: nav.backBtn)
        nav.reset(rightView: rightView)
        nav.reset(title: title)
        return nav
    }
  
    // MARK:reset
    func reset(title: String?) {
        self.title.fit(title: title, variable: SCREEN_WIDTH - W(100))
        self.title.left = (leftView != nil) ? W(43) : W(15)
        self.title.centerY = (NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)/2.0 + STATUSBAR_HEIGHT;
    }

    func reset(rightTitle: String?, _ rightBlock: (()->())?) {
        self.rightBlock = rightBlock
        let con = UIControl()
        BaseNavView.resetControl(con, rightTitle, false)
        con.addTarget(self, action: #selector(btnRightClick), for: .touchUpInside)
        self.reset(rightView: con)
    }
    
    func reset(leftTitle: String?, _ leftBlock: (()->())?) {
        self.leftBlock = leftBlock
        let con = UIControl()
        BaseNavView.resetControl(con, leftTitle, true)
        con.addTarget(self, action: #selector(btnLeftClick), for: .touchUpInside)
        self.reset(leftView: con)
    }
    
    func reset(leftImageName: String?,
               _ leftImageSize: CGSize?,
               _ leftBlock: (()->())?) {
        self.leftBlock = leftBlock
        let con = UIControl()
        BaseNavView.resetControl(con, leftImageName, leftImageSize, true)
        con.addTarget(self, action: #selector(btnLeftClick), for: .touchUpInside)
        leftView = con
        self.reset(leftView: con)
    }
    
    func reset(rightImageName: String? = nil,
               _ rightImageSize: CGSize?,
               _ rightBlock: (()->())?) {
        self.rightBlock = rightBlock
        let con = UIControl()
        BaseNavView.resetControl(con, rightImageName, rightImageSize, false)
        con.addTarget(self, action: #selector(btnRightClick), for: .touchUpInside)
        self.reset(rightView: con)
    }
    
    func reset(leftView:UIView?) {
        if self.leftView != nil {
            self.leftView?.removeFromSuperview()
            self.leftView = nil;
        }
        self.leftView = leftView;
        if let leftView = leftView {
            leftView.frame = CGRect.init(x: 0, y: (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-leftView.height/2.0, width: leftView.width, height: leftView.height)
            if self.line.superview != nil && !self.line.isHidden {
                self.insertSubview(leftView, belowSubview: self.line)
            }else{
                self.addSubview(leftView)
            }
        }
        self.reset(title: self.title.text)
    }
    
    func reset(rightView:UIView?) {
        if self.rightView != nil {
            self.rightView!.removeFromSuperview()
            self.rightView = nil
        }
        self.rightView = rightView
        if let rightView = rightView{
            rightView.frame = CGRect.init(x: SCREEN_WIDTH - rightView.width, y: (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-rightView.height/2.0, width: rightView.width, height: rightView.height)
            if self.line.superview != nil && !self.line.isHidden {
                self.insertSubview(rightView, belowSubview: self.line)
            }else{
                self.addSubview(rightView)
            }
        }
    }
    
    // MARK: btn click
    @objc func btnRightClick() {
        if let block = self.rightBlock {
            block()
        }
    }
    
    @objc func btnLeftClick() {
        if let block = self.leftBlock {
            block()
        }
    }
    
    @objc func btnBackClick() {
        if let block = self.blockBack {
            block()
        } else {
            GB_Nav.popViewController(animated: true);
        }
    }
    
    // MARK: class reset
    static func resetControl(_ control:UIView?, _ title:String?, _ isLeft:Bool) {
        guard let control = control else {
            return
        }
        control.backgroundColor = UIColor.clear
        control.removeAllSubViews()
        
        let label = UILabel()
        label.numLimit = 6
        label.numberOfLines = 1
        label.textColor = COLOR_ORANGE
        label.font = UIFont.systemFont(ofSize: BASENAVVIEW_LEFT_TITLE_FONT_NUM, weight: .regular)
        label.backgroundColor = .clear
        label.fit(title: title, variable: 0)
        
        if isLeft {
            control.frame = CGRect.init(x: 0, y: STATUSBAR_HEIGHT, width: W(100), height: NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)
            label.left = W(15)
        }else{
            control.frame = CGRect.init(x: SCREEN_WIDTH - W(100), y: STATUSBAR_HEIGHT, width: W(100), height: NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)
            label.right = control.width - W(15);
        }
        
        label.centerY = control.height/2.0;
        control.addSubview(label)
    }
    
    static func resetControl(_ control:UIView!, _ imageName:String?,_  imageSize:CGSize?, _ isLeft:Bool){
        control.backgroundColor = .clear
        control.removeAllSubViews()
        
        let iv = UIImageView.init(image: UIImage.init(named: imageName ?? ""))
        iv.widthHeight = (imageSize?.width ?? 0,imageSize?.height ?? 0)
        iv.backgroundColor = .clear
        if isLeft {
            control.frame = CGRect.init(x: 0, y: STATUSBAR_HEIGHT, width: W(100), height: NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)
            iv.left = W(10)
        }else{
            control.frame = CGRect.init(x: SCREEN_WIDTH - W(100), y: STATUSBAR_HEIGHT, width: W(100), height: NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)
            iv.right = control.width - W(10)
        }
        iv.centerY = control.height/2.0
        control .addSubview(iv)
    }
}
