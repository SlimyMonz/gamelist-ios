//
//  ListView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/23/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var dmv = Mem.dm
    
    let title: String
    var isUserList: Bool?
    
    var body: some View {
        
        if (isUserList ?? false) {
            
            List(dmv.userList) { game in
                ListCell(game: game)
            }
            .navigationTitle(title)
            
        } else {
            
            List(dmv.searchList) { game in
                ListCell(game: game)
            }
            .navigationTitle(title)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(title: "Example Title")
    }
}



