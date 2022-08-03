//
//  userlist.swift
//  gamelist
//
//  Created by Harry Hocker on 7/24/22.
//


import UIKit
import Foundation
import SwiftUI

struct userlist: View {
    
    @ObservedObject var search = userlistAPI()
    
    var body: some View {
        ScrollView{
            
            Text("Tap to display userlist.")
                .foregroundColor(.blue)
                .fontWeight(.semibold)
                .onTapGesture {
                    search.setUser(id: "insert test ID here", token: "paste test token here")
                    search.doSearch()
                }
            Text(search.list.description)
            Text(search.sent_data)
            Text(search.error)
        }
    }
}

struct userlist_Previews: PreviewProvider {
    static var previews: some View {
        userlist()
    }
}

class userlistAPI: ObservableObject {
    
    @Published var list: [GAME] = []
    @Published var error = ""
    @Published var sent_data = ""
    
    @Published var id = ""
    @Published var token = ""
    
    func setUser(id: String, token: String)
    {
        self.id = id
        self.token = "Bearer " + token
    }
    
    func doSearch()
    {
        getUserList { [weak self](list) in
            self?.list.removeAll()
            self?.list.append(contentsOf: list)
        }
    }
    
    func getUserList(completion: @escaping userlist_alias) {
        
        let url_string = Constant.base_url + Constant.userlist_url
        
        guard
            let url = URL(string: url_string)
        else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.token, forHTTPHeaderField: "authorization")
        
        let body = ["_id" : self.id]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
            else {
                self.error = "not allowed"
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
                let decodedData = try JSONDecoder().decode([GAME].self, from: data)
                    completion(decodedData)
            } catch {
                self.error = "cannot decode"
            }
        }.resume()
    }
}


typealias userlist_alias = ([GAME]) -> Void
