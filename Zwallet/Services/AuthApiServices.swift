//
//  AuthApiServices.swift
//  Zwallet
//
//  Created by DDL13 on 14/08/23.
//

import Foundation
import Moya

public class AuthApiServices {
    
    public func login(email: String, password: String, completion: @escaping(LoginModel?, Error?) -> ()) {
        
        let provider = MoyaProvider<AuthApi>()
        provider.request(.login(email: email, password: password)) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do{
                    let loginResponse = try decoder.decode(LoginResponse.self, from: result.data)
                    completion(loginResponse.data, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping(SignUpResponse?, Error?) -> ()) {
        let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.signUp(username: username, email: email, password: password)) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do{
                    let signupResponse = try decoder.decode(SignUpResponse.self, from: result.data)
                    completion(signupResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func forgotPassword(email: String, password: String, completion: @escaping(ForgotPasswordResponse?, Error?) -> ()) {
        let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.forgotPassword(email: email, password: password)) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do{
                    let forgotResponse = try decoder.decode(ForgotPasswordResponse.self, from: result.data)
                    completion(forgotResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func logout(completion: @escaping(LogoutResponse?) -> ()) {
        let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.logout) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do{
                    let logoutResponse = try decoder.decode(LogoutResponse.self, from: result.data)
                    completion(logoutResponse)
                } catch _ {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getProfile(completion: @escaping(ProfileModel?) -> ()) {
        let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        provider.request(.getProfile) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do{
                    let profileResponse = try decoder.decode(ProfilResponse.self, from: result.data)
                    completion(profileResponse.data)
                } catch _ {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
