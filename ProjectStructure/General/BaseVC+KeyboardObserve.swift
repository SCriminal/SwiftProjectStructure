//
//  BaseVC+KeyboardObserve.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/24.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

extension BaseVC {
    private struct AssociateKey {
        static var isKeyboardObserve: String = "isKeyboardObserve"
        static var firstResponserView: String = "firstResponserView"
    }
    public var isKeyboardObserve: Bool{
        get {
            return objc_getAssociatedObject(self, &AssociateKey.isKeyboardObserve) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.isKeyboardObserve, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public var firstResponserView: UIView?{
        get {
            return objc_getAssociatedObject(self, &AssociateKey.firstResponserView) as? UIView ?? nil
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.firstResponserView, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func addKeyboardObserve() {
        let nCenter: NotificationCenter! = NotificationCenter.default
        
        nCenter.addObserver(self, selector: Selector(("myTextFieldDidEndEditing:")), name: UITextField.textDidEndEditingNotification, object: nil)
        nCenter.addObserver(self, selector: Selector(("myTextFieldDidEndEditing:")), name: UITextView.textDidEndEditingNotification, object: nil)
        nCenter.addObserver(self, selector: Selector(("keyboardDidChangeFrame:")), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    //添加/移除键盘监听
    func removeKeyboardObserve() {
        let nCenter: NotificationCenter! = NotificationCenter.default
        
        nCenter.removeObserver(self, name: UITextField.textDidEndEditingNotification, object: nil)
        nCenter.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
        nCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    func myTextFieldDidEndEditing(_ noti: Notification!) {
        self.firstResponserView = nil
    }
    func keyboardDidChangeFrame(_ noti: Notification!) {
        //移动位置
        
        if let frame: CGRect = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            //    键盘的frame
            let keyHeight: CGFloat = SCREEN_HEIGHT - frame.origin.y
            //    屏幕的高度
            let keyDuration: Float = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Float ?? 0
            //    动画时间
            var yCorrect: CGFloat = 0
            
            if self.firstResponserView != nil {
                let frame = self.firstResponserView?.convert(self.firstResponserView?.bounds ?? CGRect(), to: self.view) ?? CGRect()
                
                yCorrect = -(SCREEN_HEIGHT - (frame.origin.y + frame.size.height) - keyHeight - W(120))
            }
            
            if yCorrect < 0 {
                yCorrect = 0
            }
            
            if yCorrect > keyHeight {
                yCorrect = keyHeight
            }
            
            //if on the bottom,remove keyHeight Most
            UIView.animate(withDuration: TimeInterval(keyDuration)) {
                //    执行动画
                let transformY: CGFloat = keyHeight == 0 ? 0 : -yCorrect
                
                self.view.transform = CGAffineTransform(translationX: 0, y: transformY)
            }
        }
        
    }
}
