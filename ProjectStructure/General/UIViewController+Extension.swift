//
//  UIViewController+Extension.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/24.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    private struct AssociateKey {
        static var isSlideLeftValid: String = "isSlideLeftValid"
        static var requestState: String = "requestState"
        static var blockBack: String = "blockBack"
    }
    
    public var isSlideLeftValid: Bool{
        get {
            return objc_getAssociatedObject(self, &AssociateKey.isSlideLeftValid) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.isSlideLeftValid, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public var requestState: Int{
        get {
            return objc_getAssociatedObject(self, &AssociateKey.requestState) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.requestState, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public var blockBack : (()->UIViewController)? {
        get {
            return objc_getAssociatedObject(self, &AssociateKey.blockBack) as? ()->UIViewController ?? nil
        }
        set {
            objc_setAssociatedObject(self, &AssociateKey.blockBack, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
