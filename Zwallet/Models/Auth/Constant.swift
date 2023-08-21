//
//  Constant.swift
//  Zwallet
//
//  Created by DDL13 on 19/08/23.
//

import Foundation

class Constant {
    static var baseURL: String {
        return Bundle.main.infoDictionary?["BaseURL"] as? String ?? ""
    }
    
    static var Token = UserDefaults.standard.value(forKey: "AccessToken")
    static var firsName = UserDefaults.standard.value(forKey: "firstName")
    static var lastName = UserDefaults.standard.value(forKey: "lastName")
    static var phone = UserDefaults.standard.value(forKey: "phone")
    static var image = UserDefaults.standard.value(forKey: "image")
}
