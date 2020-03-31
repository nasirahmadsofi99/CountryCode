//
//  CountryCodes.swift
//  DT Mednet
//
//  Created by IOS on 29/05/19.
//  Copyright © 2019 Deftsoft. All rights reserved.
//

import Foundation

class CountryCode {
    
    static var shared = CountryCode()
    private init() {}

    
    func getPhoneCodeArray() -> [String] {
        var codeArray = [String]()
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonArray = jsonResult as? [JSONDictionary] {
                    for i in jsonArray {
                        if var countryCode = i["dial_code"] as? String {
                            countryCode = countryCode.replacingOccurrences(of: " ", with: "")
                            if countryCode.count > 0 {
                                codeArray.append(countryCode)
                            }
                        }
                    }
                    //Remove duplicate value
                    codeArray = Array(Set(codeArray))
                    codeArray = codeArray.sorted()
                }
            } catch {
                // handle error
            }
        }
        return codeArray
    }
}

//typealias JSONDictionary = [String:Any]
//typealias JSONArray = [JSONDictionary]
