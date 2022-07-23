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
    
    var body: some View {
        VStack{
            Text(dvm.token)
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.setPlatform(platform: "Xbox One")
                vm.doSearch()
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
    
    @State var platform = ""
    @ObservedObject var dmv = Mem.dm
    
    func setPlatform(platform: String) {
        self.platform = platform
    }
    
    func doSearch() {
        getGameList { [self](list) in
            self.dmv.searchList = list
        }
    }
    
    func getGameList(completion: @escaping search_alias) {
        
        guard
            let url = URL(string: Constant.base_url + Constant.login_url)
        else {

            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // authenticate only if we need the user's specific list
        

        let body = ["platform" : "[" + self.platform + "]"]
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
                let decodedData = try JSONDecoder().decode(GAMELIST.self, from: data)
                completion(decodedData)
            } catch {

            }
        }.resume()
    }
    
}

typealias search_alias = (GAMELIST) -> Void

struct GAMELIST: Decodable
{
    let list: [GAME]
    
    enum CodingKeys: String, CodingKey
    {
        case list = "games"
    }
    
}


struct GAME: Decodable
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
