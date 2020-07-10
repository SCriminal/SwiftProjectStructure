
//
//  Array+Extension.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/9.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

extension Array {
    static func exchange<T: Decodable>(response: Any?, modelClass: T.Type) -> Array{
        var aryReturn = Array()
        do {
            if let ary = (response as? Array<Any>) {
                for item in ary {
                    if let dic = item as? Dictionary<String, Any?> {
                      let model = try JSONDecoder().decode(modelClass, from: JSONSerialization.data(withJSONObject: dic, options: [])) as? Element
                        if let model = model {
                            aryReturn.append(model)
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
        return aryReturn
    }
}
