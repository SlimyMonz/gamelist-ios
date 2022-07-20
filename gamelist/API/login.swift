//
//  login.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import UIKit
import Foundation
import SwiftUI

struct login: View {
    
    @StateObject var vm = loginAPI()
    
    @State var name = "nothing"
    
    var body: some View {
        VStack{
        Text(vm.jwt_token)
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setInfo(username: "monz", password: "password")
                vm.getData()
                name = vm.username
            }
        Text(name)
        }
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}


class loginAPI: ObservableObject {
    
    @Published var jwt_token: String = "null"
    @Published var username: String = ""
    @Published var password: String = ""
    
    func setInfo(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func getData() {
        getJWT { (returnedData) in
            self.jwt_token = returnedData.firstName
        }
    }
    
    func getJWT(completion: @escaping decode_alias) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.login_url)
        else {

            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["userName": username, "password": password]
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
                let payload = try decode_jwt(jwtToken: decodedData.token)
                completion(payload)
            } catch {

            }
        }.resume()
    }
    
}


typealias decode_alias = (USER) -> Void

struct JWT: Decodable
{
    let token: String
    
    enum CodingKeys: String, CodingKey
    {
        case token = "token"
    }
}


struct USER: Decodable
{
    let firstName: String
    let lastName: String
    let email: String
    let userName: String
    let userID: String
    
    enum CodingKeys: String, CodingKey
    {
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case userName = "userName"
        case userID = "id"
    }
}





