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
    
    @StateObject var vm = searchAPI()
    @ObservedObject var dvm = Mem.dm
    
    @State var error = "no error"
    
    var body: some View {
        
        
        VStack{
            
            Text("Tap to search.")
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setPlatform(platform: "Xbox One")
                vm.doSearch()
            }
            ScrollView{
                Text(dvm.searchList.description)
            }
                Text(vm.platform)
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
    @ObservedObject var dmv = Mem.dm
    
    func setPlatform(platform: String) {
        self.platform = platform
    }
    
    func doSearch() {
        getGameList { [self](list) in
            self.dmv.searchList.append(contentsOf: list)
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




struct GAME: Decodable, Identifiable
{
    let id: String
    let name: String
    let description: String
    let cover: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case description = "description"
        case cover = "cover"
    }
}
