//
//  OptionalStringCoalesce.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/7.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}
