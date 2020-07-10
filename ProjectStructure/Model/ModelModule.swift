// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   var modelModule = try? newJSONDecoder().decode(ModelModule.self, from: jsonData)

import Foundation

// MARK: - ModelModule
struct ModelModule: Codable {
    var android: String?
    var createTime, goMode: Int?
    var iconURL: String?
    var id: Int?
    var ios: String?
    var isAndroid, isIos, isLogin, isOpen: Int?
    var isURL: Int?
    var name: String?
    var sort: Int?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case android, createTime, goMode
        case iconURL = "iconUrl"
        case id, ios, isAndroid, isIos, isLogin, isOpen
        case isURL = "isUrl"
        case name, sort, url
    }
    
    static func model(dictionary: Dictionary<String, Any?>){
        
    }
}
