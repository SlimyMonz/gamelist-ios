//
//  ListView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/23/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var vm: ListViewModel
    
    let platform: String

    var body: some View {

            List(vm.list) { game in
                ListCell(game: game)
            }
            .navigationTitle(platform)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(vm: ListViewModel(), platform: "Example Title")
    }
}


class ListViewModel: ObservableObject {
    
    @Published var list: [GAME] = []
    
    func addGames(list: [GAME]) {
        self.list.append(contentsOf: list)
        self.list.sort { $0.name! < $1.name! }
    }
    
    func removeGames() {
        self.list.removeAll()
    }
}
