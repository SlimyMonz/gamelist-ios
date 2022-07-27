//
//  register.swift
//  gamelist
//
//  Created by Harry Hocker on 7/21/22.
//

import UIKit
import Foundation
import SwiftUI

struct registerView: View {
    
    @StateObject var vm = registerAPI()
    @ObservedObject var dvm = Mem.dm
    
    @State var jwt_token: String = "empty"
    @State var username: String = ""
    @State var password: String = ""
    
    @State var buttonPressed = ""
    @State var errorText = ""
    
    let checkEmail = "Check your email!"
    
    var body: some View {
        VStack{
            Text("press to register")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setInfo(
                    user: "empty",
                    pass: "empty",
                    first: "empty",
                    last: "empty",
                    email: "khyrdantai@icloud.com"
                )
                self.buttonPressed = checkEmail
                vm.sendData()
                self.errorText = vm.error
            }
            Text(buttonPressed)
                .foregroundColor(.green)
            Text(errorText)
                .foregroundColor(.red)
            Text(vm.error)
        }
    }
}

struct register_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
    }
}


class registerAPI: ObservableObject {
    
    @Published var username: String = "no user"
    @Published var password: String = ""
    @Published var first_name: String = ""
    @Published var last_name: String = ""
    @Published var email: String = ""

    @Published var error = ""
    
    @ObservedObject var dmv = Mem.dm
    
    func setInfo(
        user: String,
        pass: String,
        first: String,
        last: String,
        email: String
    ) {
        self.username = user
        self.password = pass
        self.first_name = first
        self.last_name = last
        self.email = email
    }
    
    func sendData() {
        sendRegister { (data) in
            if (!data.message.isEmpty) {
                self.dmv.registered = true
                self.dmv.id = data.id
                self.sendEmail { (response) in
                    self.error = response
                }
            } else {
                self.error = "Invalid."
            }
        }
    }
    
    func sendRegister(completion: @escaping (REGISTER) -> Void) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.register_url)
        else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // add token to request in here somewhere

        let body = [
            "userName": username,
            "password": password,
            "firstName": first_name,
            "lastName": last_name,
            "email": email
        ]
            
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
                let decodedData = try JSONDecoder().decode(REGISTER.self, from: data)
                completion(decodedData)
            } catch {
                return
            }
            
        }.resume()
    }
    
    func sendEmail(completion: @escaping (String) -> Void) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.email_url)
        else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // add token to request in here somewhere

        let body = [
            "id": dmv.id,
            "firstName": first_name,
            "email": email
        ]
            
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
            else {
                completion("no http response")
                return
            }
            guard
                error == nil
            else {
                completion("error")
                return
            }
            completion("200")
            
        }.resume()
    }
}
