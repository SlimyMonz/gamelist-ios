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
        Text(vm.id)
            Text(vm.verified.description)
        }
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}


class loginAPI: ObservableObject {
    
    @Published var jwt_token: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var id: String = ""
    @Published var verified: Bool = false
    
    func setInfo(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func getData() {
        getJWT { (token, user) in
            self.jwt_token = token
            self.id = user.id
            self.verified = user.verified
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
                let payload = decode_jwt(jwt: self.jwt_token)
                completion(decodedData.token, payload!)
            } catch {

            }
        }.resume()
    }
    
}

typealias decode_alias = (String, USER) -> Void










