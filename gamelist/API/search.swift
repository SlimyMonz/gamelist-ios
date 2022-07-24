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
    
    @StateObject var search = searchAPI()
    @State var error = "no error"
    
    var body: some View {
        VStack{
            
            Text("Tap to search.")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                search.setPlatform(platform: "Xbox One")
                search.doSearch()
            }
            
                ListView()
            
        }
    }
}

struct search_Previews: PreviewProvider {
    static var previews: some View {
        search()
    }
}

class searchAPI: ObservableObject {
    
    @Published var error = ""
    @Published var platform = ""
    @Published var isUserList = false
    
    func setPlatform(platform: String) {
        self.platform = platform
    }
    
    func setUserList() {
        self.isUserList = true
    }
    
    func doSearch()
    {
        getGameList { (list) in
            if (self.isUserList) {
                Mem.dm.userList.removeAll()
                Mem.dm.userList.append(contentsOf: list)
            } else {
                Mem.dm.searchList.removeAll()
                Mem.dm.searchList.append(contentsOf: list)
            }
        }
    }
    
    func getGameList(completion: @escaping search_alias) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.game_url)
        else {

            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // authenticate only if we need the user's specific list
        

        let body = ["platform" : [self.platform ]]
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

typealias search_alias = ([GAME]) -> Void



