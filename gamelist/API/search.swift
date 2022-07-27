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
    @ObservedObject var vm = ListViewModel()
    
    
    var body: some View {
        
        VStack{
            
            Text("Tap to search.")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                // THESE ARE WHAT YOU WANT TO DO FOR EACH SEARCH!!!
                search.setPlatform(platform: Constant.ps3)
                search.getGameList { [self](list) in
                    self.vm.removeGames()
                    self.vm.addGames(list: list)
                }
                
            }
            Text(vm.list.description)
            ListView(vm: vm, platform: "Search")
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
    @Published var list: [GAME] = []
    
    func setPlatform(platform: String) {
        self.platform = platform
    }
    
    func doSearch()
    {
        getGameList { [weak self](list) in
            self?.list.removeAll()
            self?.list.append(contentsOf: list)
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



