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
    
    @StateObject var search = userlistAPI()
    
    var body: some View {
        VStack{
            
            Text("Tap to search.")
                .foregroundColor(.blue)
                .fontWeight(.semibold)
                .onTapGesture {
                    search.setPlatform(platform: "Xbox One")
                    search.doSearch()
                }
            ListView(title: "User List", isUserList: true)
            
        }
    }
}

struct userlist_Previews: PreviewProvider {
    static var previews: some View {
        userlist()
    }
}

class userlistAPI: ObservableObject {
    
    @Published var platform = ""
    
    func setPlatform(platform: String) {
        self.platform = platform
    }
    
    func doSearch()
    {
        getUserList { (list) in
            Mem.dm.userList.removeAll()
            Mem.dm.userList.append(contentsOf: list)
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
        request.addValue("Bearer " + Mem.dm.token, forHTTPHeaderField: "authentication")
        
        let body = ["_id" : Mem.dm.id]
        
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
                let decodedData = try JSONDecoder().decode([GAME].self, from: data)
                completion(decodedData)
            } catch {
                
            }
        }.resume()
    }
}


typealias userlist_alias = ([GAME]) -> Void
