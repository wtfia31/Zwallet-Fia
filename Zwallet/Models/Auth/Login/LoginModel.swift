//
//  LoginModel.swift
//  Zwallet
//
//  Created by DDL13 on 14/08/23.
//

import Foundation

public struct LoginModel: Codable {
    public var id: Int
    public var email: String
    public var token: String
}
