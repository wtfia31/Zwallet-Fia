//
//  ProfileResponse.swift
//  Zwallet
//
//  Created by DDL13 on 19/08/23.
//

import Foundation

public struct ProfilResponse: Codable {
    public var status: Int
    public var messages: String
    public var data: ProfileModel
}

