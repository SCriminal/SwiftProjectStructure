import UIKit

// Preprocessor directives found in file:

//
//  LoadingView.h
//  米兰港
//
//  Created by 隋林栋 on 15/3/5.
//  Copyright (c) 2015年 Sl. All rights reserved.
//
//
//  LoadingView.m
//  米兰港
//
//  Created by 隋林栋 on 15/3/5.
//  Copyright (c) 2015年 Sl. All rights reserved.
//
class LoadingView: UIView {
    lazy var imageLoading: UIImageView! = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "加载中")
        iv.widthHeight = (W(34), W(34))
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.imageLoading)

        self.imageLoading.center = (x: self.width / 2.0, y: self.height / 2.0)

        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetFrame(_ frame: CGRect, viewShow: UIView!) {
        self.frame = frame

        self.imageLoading.center = (self.width / 2.0, self.height / 2.0 - W(30))

        viewShow.addSubview(self)

        self.beginAnimate()
    }
    func hideLoading() {
        self.stopAnimate()
        self.removeFromSuperview()
    }
    //begin animate
    func beginAnimate() {
        //begin animate
        self.stopAnimate()

        let animate: CABasicAnimation! = CABasicAnimation(keyPath: "transform.rotation")

        animate.toValue = Double.pi * 2
        animate.repeatCount = MAXFLOAT
        animate.duration = 2
        animate.isRemovedOnCompletion = true
        self.imageLoading.layer.add(animate, forKey: "animated")
    }
    //stop animate
    func stopAnimate() {
        //stop animate
        self.imageLoading.layer.removeAllAnimations()
    }
}
