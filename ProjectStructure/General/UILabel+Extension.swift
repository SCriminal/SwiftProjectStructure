//
//  UILabel+Extension.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/24.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

extension UILabel: SelfAware{
    //protocol SelfAware
    static func awake() {
        UILabel.takeOnceTime
    }
    private static let takeOnceTime: Void = {
        let originalSelector = #selector(setter: UILabel.text)
        let swizzledSelector = #selector(sld_setText(_:))
        
        swizzlingForClass(UILabel.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc public func sld_setText(_ text: String?) {
        if let str = text ,self.numLimit>0 {
            let subStr = str.prefix(self.numLimit);
            self.sld_setText(String(subStr))
        }else{
            self.sld_setText(text)
        }
    }
    
    
    private struct AssociateKey {
        static var lineSpace: String = "lineSpace"
        static var numLimit: String = "numLimit"
    }
    
    public var lineSpace: Float{
        get {
            return objc_getAssociatedObject(self, &AssociateKey.lineSpace) as? Float ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.lineSpace, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public var numLimit: Int{
        get {
            return objc_getAssociatedObject(self, &AssociateKey.numLimit) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.numLimit, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public var fontNum: CGFloat{
        get{
            return self.font.pointSize
        }
        set{
            self.font = UIFont.systemFont(ofSize: newValue, weight: .regular)
        }
    }
    
    
    /**
     可变宽度
     
     @param width 宽度
     */
    func fit(title: String?,variable width: CGFloat) {
        
        self.text = title
        
        guard title != nil  else {
            self.widthHeight = (0, self.font.lineHeight)
            return
        }
        
        let string = title!
        
        if string.count==0 {
            self.widthHeight = (0, self.font.lineHeight)
            return
        }
        
        let size = string.boundingRect(with: CGSize(width: width==0 ? CGFloat.greatestFiniteMagnitude :width, height: CGFloat.greatestFiniteMagnitude), font: self.font, lineSpacing: CGFloat(self.lineSpace), lines: self.numberOfLines)
        
        self.widthHeight = (size.width, size.height)
        
    }
    
    //fetch height
    func setNormalShadow() {
        self.set(shadowColor: UIColor.black, range: NSMakeRange(0, self.text?.count ?? 0), offsetsize: CGSize(width: 0, height: 1))
    }
    
    func set(shadowColor: UIColor!, range: NSRange, offsetsize size: CGSize) {
        let str: NSMutableAttributedString! = NSMutableAttributedString(string: self.text ?? "")
        //设置label默认阴影
        let shadow = NSShadow()
        
        shadow.shadowBlurRadius = 1.0
        shadow.shadowOffset = size
        shadow.shadowColor = shadowColor
        
        str.addAttribute(NSAttributedString.Key.shadow, value: shadow, range: range)
        
        //设置label阴影
        self.attributedText = str
    }
    
}
