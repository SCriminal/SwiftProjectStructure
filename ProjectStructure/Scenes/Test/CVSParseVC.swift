//
//  CVSParseVC.swift
//  ProjectStructure
//
//  Created by 隋林栋 on 2020/7/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation

let kCSVFileName = "carType"
let kCSVFileExtension = "txt"

class CSVParseVC: BaseVC {
    lazy var submitButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(parseClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("parse", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    lazy var originButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 1
        button.addTarget(self, action: #selector(originClick), for: .touchUpInside)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: F(18))
        button.setTitle("origin", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthHeight = (100,40)
        button.addRoundCorner(corner: .allCorners, radius: 5, lineWidth: 0, lineColor: .clear)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(BaseNavView.initNavBack(title: "Parse"))
        submitButton.leftTop = (0, NAVIGATIONBAR_HEIGHT)
        self.view.addSubview(submitButton)
        originButton.leftTop = (0, submitButton.bottom)
        self.view.addSubview(originButton)

        
    }
    
    @objc func originClick() {
        let data = readDataFromCSV(fileName: "CarTypeOrigin", fileType: "json")
        let object = try! JSONSerialization.jsonObject(with: (data?.data(using: .utf8))!, options: [])
        
        let filePath:String = NSHomeDirectory() + "/Documents/LicenseTypeOrigin.json"
        let info = String.init(data:try!  JSONSerialization.data(withJSONObject: object, options: [.sortedKeys, .prettyPrinted]), encoding: .utf8)
        try! info?.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)

    }
    
    @objc func parseClick() {
        var data = readDataFromCSV(fileName: kCSVFileName, fileType: kCSVFileExtension)
        data = cleanRows(file: data ?? "")
        let csvRows = csv(data: data ?? "")
        var aryJson = Array<Dictionary<String, Any>>.init()
        
        for strs in csvRows {
            if strs.count<5 {
                continue
            }
            let value = Int(strs[0]) ?? 0
            let label = strs[2]
            let value2 = strs[1]
            let status = Int(strs[4]) ?? 0
            aryJson.append(["value":value, "label":label, "value2":value2, "status":status])
        }
        let filePath:String = NSHomeDirectory() + "/Documents/LicenseType.json"
        let info = String.init(data:try!  JSONSerialization.data(withJSONObject: aryJson, options: [.sortedKeys, .prettyPrinted]), encoding: .utf8)
        try! info?.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        
        print(csvRows)
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
}
