//
//  UIView+Extension.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/23.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set{
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var right : CGFloat {
        get {
            return left + width
        }
        
        set(newVal) {
            left = newVal - width
        }
    }
    
    var top: CGFloat {
        set {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
        get {
            return frame.origin.y
            
        }
    }
    
    var bottom : CGFloat {
        get {
            return top + height
        }
        
        set(newVal) {
            top = newVal - height
        }
    }
    
    var width : CGFloat {
        get {
            return frame.size.width
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    var height : CGFloat {
        get {
            return frame.size.height
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    var center: (x:CGFloat, y:CGFloat) {
        get {
            return (x:bounds.width / 2.0 + left, y: bounds.height / 2.0 + top)
        }
        set (newValue){
            left = newValue.x - width/2.0
            top = newValue.y - height/2.0
        }
    }
    
    var leftTop: (x:CGFloat, y:CGFloat) {
        get {
            return (left,top)
        }
        set (newValue){
            left = newValue.x
            top = newValue.y
        }
    }
    
    var leftBottom: (x:CGFloat, y:CGFloat) {
        get {
            return (left,bottom)
        }
        set (newValue){
            left = newValue.x
            bottom = newValue.y
        }
    }
    
    var centerXBottom: (x:CGFloat, y:CGFloat) {
        get {
            return (left+width/2.0,bottom)
        }
        set (newValue){
            left = newValue.x - width/2.0
            bottom = newValue.y
        }
    }
    
    var centerXTop: (x:CGFloat, y:CGFloat) {
        get {
            return (left+width/2.0,top)
        }
        set (newValue){
            left = newValue.x - width/2.0
            top = newValue.y
        }
    }
    
    var rightTop: (x:CGFloat, y:CGFloat) {
        get {
            return (right,top)
        }
        set (newValue){
            right = newValue.x
            top = newValue.y
        }
    }
    
    var rightCenterY: (x:CGFloat, y:CGFloat) {
        get {
            return (right,top+height/2.0)
        }
        set (newValue){
            right = newValue.x
            top = newValue.y - height/2.0
        }
    }
    
    var rightBottom: (x:CGFloat, y:CGFloat) {
        get {
            return (right,bottom)
        }
        set (newValue){
            right = newValue.x
            top = newValue.y - height
        }
    }
    
    var widthHeight: (x:CGFloat, y:CGFloat) {
        get {
            return (width,height)
        }
        set (newValue){
            width = newValue.x
            height = newValue.y
        }
    }
    
    var centerX: (CGFloat) {
        get {
            return width / 2.0 + left
        }
        set (newValue){
            left = newValue - width/2.0
        }
    }
    
    var centerY: (CGFloat) {
        get {
            return height / 2.0 + top
        }
        set (newValue){
            top = newValue - height/2.0
        }
    }
    
    func addRoundCorner(corner:UIRectCorner, radius:CGFloat) -> () {
        self .addRoundCorner(corner: corner, radius: radius, lineWidth: 0, lineColor: nil)
    }
    
    func addRoundCorner(corner:UIRectCorner, radius:CGFloat, lineWidth:CGFloat, lineColor:UIColor?) -> () {
        self.layer.masksToBounds = true
        
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        if lineWidth > 0 {
            let borderLayer = CAShapeLayer()
            borderLayer.path = maskPath.cgPath
            borderLayer.fillColor = UIColor.white.cgColor
            borderLayer.strokeColor = lineColor?.cgColor
            borderLayer.lineWidth = lineWidth
            borderLayer.frame = self.bounds
            self.layer.addSublayer(borderLayer)
        }
    }
    func removeCorner() -> () {
        self.layer.mask?.removeFromSuperlayer()
        self.layer.sublayers?.forEach({ layer in
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        })
    }
    
    func removeAllSubViews() {
        while (self.subviews.count > 0) {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    func removeSubView(tag: Int) {
        for item in self.subviews {
            if item.tag == tag {
                item.removeFromSuperview()
            }
        }
    }
    
    func isShowInScreen() -> Bool {
        let screenRect = UIScreen.main.bounds
        let rectInWindow = self.superview?.convert(self.frame, to: UIApplication.shared.keyWindow)
        guard let rect = rectInWindow, rect.isEmpty == false else {
            return false
        }
        guard self.isHidden == false else {
            return false
        }
        guard self.superview != nil else {
            return false
        }
        guard rect.equalTo(CGRect.zero) == false else {
            return false
        }
        
        let interSectionRect = rect.intersection(screenRect)
        if interSectionRect.isEmpty || interSectionRect.isNull {
            return false
        }
        return true
    }
}
