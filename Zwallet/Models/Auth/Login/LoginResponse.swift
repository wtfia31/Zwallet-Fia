//
//  LoginResponse.swift
//  Zwallet
//
//  Created by DDL13 on 14/08/23.
//

import Foundation

public struct LoginResponse: Codable {
    public var status: Int
    public var message: String
    public var data: LoginModel
}
