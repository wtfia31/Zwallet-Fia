//
//  AuthApi.swift
//  Zwallet
//
//  Created by DDL13 on 14/08/23.
//

import Foundation
import Moya

let baseUrl = "http://54.158.117.176:8000"

public enum AuthApi {
    case login(email: String, password: String)
    case signUp(username: String, email: String, password: String)
    case forgotPassword(email: String, password: String)
    case logout
    case getProfile
}

extension AuthApi: TargetType {
    public var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signUp:
            return "/auth/signup"
        case .forgotPassword:
            return "/auth/reset"
        case .logout:
            return "/auth/logout/\(Constant.Token ?? "")"
        case .getProfile:
            return "/user/myProfile"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        case .forgotPassword:
            return .patch
        case .logout:
            return .delete
        case .getProfile:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(
                parameters: ["email": email, "password": password], encoding: URLEncoding.default)
        case .signUp(username: let username, email: let email, password: let password):
            return .requestParameters(
                parameters: ["username": username, "email": email, "password": password], encoding: URLEncoding.default)
        case .forgotPassword(email: let email, password: let password):
            return .requestParameters(
               parameters: ["email": email, "password": password], encoding: URLEncoding.default)
        case .logout, .getProfile:
            return .requestPlain
        
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login, .signUp, .forgotPassword:
            return nil
        case .logout, .getProfile:
            return ["Authorization" : "Bearer \(Constant.Token ?? "")"]
        }
    }
    
}
