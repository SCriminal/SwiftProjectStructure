//
//  String+Extension.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/6/28.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func fetchWidthFontNum(_ fontNum: Float) -> Float {
        return Float(self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude,height: CGFloat.greatestFiniteMagnitude), font: UIFont.systemFont(ofSize: CGFloat(fontNum))).width)
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        return size
    }
    
    func base64Encode() -> String {
        let data = self.data(using: .utf8)
        let base64Data = data?.base64EncodedData() ?? Data()
        let baseString = String.init(data: base64Data, encoding: .utf8)
        return baseString ?? ""
    }
    
    func base64Decode() -> String {
        let data = Data.init(base64Encoded: self)
        return String.init(data: data ?? Data(), encoding: .utf8) ?? ""
    }
    
    
    //拼接url
    func appendUrl(value:String?, key:String?) -> String! {
        guard let value = value, let key = key else {
            return self
        }
        if self.contains(key + "=") {
            return self
        }
        if self.firstIndex(of: "?") != nil {
            if self.hasSuffix("?") || self.hasSuffix("&") {
                return self + key + "=" + value
            } else {
                return self + "&" + key + "=" + value
            }
        } else {
            if self.hasSuffix("&") {
                let sub = self[..<self.index(self.startIndex, offsetBy: self.count - 1)]
                return String(sub) + "?" + key + "=" + value
            }
            return self + "?" + key + "=" + value
        }
    }
}
