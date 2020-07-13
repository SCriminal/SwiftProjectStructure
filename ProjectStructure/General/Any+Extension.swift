//
//  Any+Extension.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/13.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

protocol Flattenable {
  func flattened() -> Any?
}

extension Optional: Flattenable {
  func flattened() -> Any? {
    switch self {
    case .some(let x as Flattenable): return x.flattened()
    case .some(let x): return x
    case .none: return nil
    }
  }
}
