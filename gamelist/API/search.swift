//
//  search.swift
//  gamelist
//
//  Created by Harry Hocker on 7/22/22.
//

import UIKit
import Foundation
import SwiftUI

struct search: View {
    
    @StateObject var vm = loginAPI()
    @ObservedObject var dvm = Mem.dm
    
    @State var jwt_token: String = "empty"
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            Text(dvm.token)
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setInfo(username: "monz", password: "password")
                vm.getData()
            }
        }
    }
}

struct search_Previews: PreviewProvider {
    static var previews: some View {
        search()
    }
}


class searchAPI: ObservableObject {
    
    @State var getUserList = false
    
    @ObservedObject var dmv = Mem.dm
    
    func getList() {
        getUserList = true
        doSearch()
    }
    
    func doSearch() {
        getJWT { [weak self](user_list) in
            
        }
    }
    
    func getJWT(completion: @escaping search_alias) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.login_url)
        else {

            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // authenticate only if we need the user's specific list
        if (self.getUserList) {
            request.addValue("Bearer " + dmv.token, forHTTPHeaderField: "Authentication")
        }

        let body = ["_id" : dmv.id]
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

typealias search_alias = (JWT) -> Void

