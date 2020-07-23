//
//  NoResultView.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/22.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

class NoResultView: UIView {
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: F(17), weight: .medium)
        label.textColor = UIColor.init(hexString: "BABABA")
        return label
    }()
    
    lazy var ivNoResult: UIImageView = {
        let imageView = UIImageView()
        imageView.widthHeight = (W(260), W(148))
        return imageView
    }()
    
    lazy var btnAdd: UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(btnAddClick), for: .touchUpInside)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(15))
        button.setTitle("", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.widthHeight = (W(235),W(45))
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        button.isHidden = true
        return button
    }()
    
    var blockAddClick: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(labelTitle)
        self.addSubview(ivNoResult)
        self.addSubview(btnAdd)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(view: UIView, frame: CGRect) {
        self.frame = frame
        self.resetView()
        view.addSubview(self)
    }
    
    private func resetView() {
        self.removeSubView(tag: TAG_LINE)
        self.ivNoResult.centerXTop = (self.width/2.0, W(122))
        self.labelTitle.centerXTop = (self.width / 2,self.ivNoResult.bottom + W(50))
        self.btnAdd.centerXTop = (self.width / 2,self.ivNoResult.bottom + W(80))
    }
    
    func reset(imageName: String, title: String) {
        self.ivNoResult.image = UIImage.init(named: imageName)
        self.labelTitle.fit(title: title, variable: 0)
    }
    
    // MARK:
    @objc func btnAddClick() {
        if let block = blockAddClick {
            block()
        }
    }
    
}
