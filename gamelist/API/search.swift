//
//  search.swift
//  gamelist
//
//  Created by Harry Hocker on 7/22/22.
//

import UIKit
import Foundation
import SwiftUI

struct searchview: View {
    
    @StateObject var search = searchAPI()
    
    var body: some View {
        VStack{
            
            Text("Tap to search.")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                search.setPlatform(platform: Constant.ps5)
                search.doSearch()
            }

            ListView(title: "Search")
        }
    }
}

struct searchview_Previews: PreviewProvider {
    static var previews: some View {
        searchview()
    }
}

class searchAPI: ObservableObject {
    
    @Published var platform = ""
    
    func setPlatform(platform: String) {
        self.platform = platform
    }
    
    func doSearch()
    {
        getGameList { (list) in
                Mem.dm.searchList.removeAll()
                Mem.dm.searchList.append(contentsOf: list)
        }
    }
    
    func getGameList(completion: @escaping search_alias) {
        
        let url_string = Constant.base_url + Constant.game_url
        
        guard
            let url = URL(string: url_string)
        else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let body = ["platform" : [self.platform]]
        
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



