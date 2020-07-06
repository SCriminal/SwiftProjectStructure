//
//  RequestApi.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/6.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

enum ENUM_REQUEST_TYPE {
    case ENUM_REQUEST_GET
    case ENUM_REQUEST_POST
    case ENUM_REQUEST_PATCH
    case ENUM_REQUEST_DELETE
    case ENUM_REQUEST_PUT
}

protocol RequestDelegate {
    var isNotShowNoticeView: Bool {
        get
        set
    }
    func protocolWillRequest()
    func protocolDidRequestSuccess()
    func protocolDidRequestFailure() -> String
}

extension RequestDelegate {
    func protocolWillRequest() {
        
    }
    func protocolDidRequestSuccess() {
        
    }
    func protocolDidRequestFailure() -> String {
        return ""
    }
}
