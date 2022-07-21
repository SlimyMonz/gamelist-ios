//
//  register.swift
//  gamelist
//
//  Created by Harry Hocker on 7/21/22.
//

import UIKit
import Foundation
import SwiftUI

struct register: View {
    
    @StateObject var vm = registerAPI()
    @ObservedObject var dvm = Mem.dm
    
    @State var jwt_token: String = "empty"
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            Text("press to register")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setInfo(
                    user: "monz",
                    pass: "empty",
                    confirm: "empty",
                    first: "Harry",
                    last: "Hocker",
                    email: "harry_hocker@icloud.com"
                )
                vm.sendData()
            }
        }
    }
}

struct register_Previews: PreviewProvider {
    static var previews: some View {
        register()
    }
}


class registerAPI: ObservableObject {
    
    @Published var username: String = "no user"
    @Published var password: String = ""
    @Published var confirm_pass: String = ""
    @Published var first_name: String = ""
    @Published var last_name: String = ""
    @Published var email: String = ""
    
    @ObservedObject var dmv = Mem.dm
    
    func setInfo(
        user: String,
        pass: String,
        confirm: String,
        first: String,
        last: String,
        email: String
    ) {
        self.username = user
        self.password = pass
        self.confirm_pass = confirm
        self.first_name = first
        self.last_name = last
        self.email = email
    }
    
    func sendData() {
        sendRegister { [weak self](response) in
            // most likely change the response thingy here
            if (response != "200") {self?.dmv.registered = true}
        }
    }
    
    func sendRegister(completion: @escaping (String) -> Void) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.register_url)
        else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // add token to request in here somewhere

        let body = ["userName": username, "password": password]
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
            completion(httpResponse.description)
            
        }.resume()
    }
}
