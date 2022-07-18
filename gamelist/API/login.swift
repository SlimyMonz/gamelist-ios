//
//  login.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import UIKit
import Foundation

class loginAPI: ObservableObject {
    
    @Published var jwt_token: String = "null"
    @Published var username: String = ""
    @Published var password: String = ""
    
    func getInfo(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func getData() {
        getJWT { (returnedData) in
            self.jwt_token = returnedData.token
        }
    }
    
    func getJWT(completion: @escaping jwt_alias) {
        
        guard
            let url = URL(string: Constant.url_base + Constant.login_url)
        else {

            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["userName": $username, "password": $password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
            else {
                return
            }
            guard
                error == nil
            else {
                return
            }
            guard
                let data = data
            else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(JWT.self, from: data)
                completion(decodedData)
            } catch {

            }
        }.resume()
    }
}

typealias jwt_alias = (JWT) -> Void

struct JWT: Decodable {
    let token: String
    enum CodingKeys: String, CodingKey
    {
        case token = "token"
    }
}


// this may or may not be used at some point to pass data out

struct UserLogin: Decodable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var userName: String?
    var userID: String?
}




