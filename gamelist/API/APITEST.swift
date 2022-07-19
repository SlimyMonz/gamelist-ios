//
//  ApiTest.swift
//  testingClosures
//
//  Created by Harry Hocker on 7/17/22.
//

/*
import SwiftUI

struct ApiTest: View {
    
    @StateObject var vm = loginAPI()
    
    var body: some View {
        Text(vm.jwt_token)
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct ApiTest_Previews: PreviewProvider {
    static var previews: some View {
        ApiTest()
    }
}


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
            let url = URL(string: "https://my-game-list-front.herokuapp.com/api/users/login/")
        else {

            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["userName": "someguy", "password": "test"]
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



*/
