//
//  ListView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/23/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var dmv = Mem.dm
    
    
    var body: some View {
        
        NavigationView {
            
            List(dmv.searchList) { game in
                ListCell(name: game.name, description: game.description)
            }
            
            .navigationTitle("My Game List")
        }
        
        
        
       
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}



