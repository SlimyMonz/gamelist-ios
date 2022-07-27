//
//  ListItem.swift
//  gamelist
//
//  Created by Harry Hocker on 7/24/22.
//

import SwiftUI

struct ListCell: View {
    
    let game: GAME
    
    var body: some View {

            NavigationLink {
                GameView(game: game)
            } label: {
                VStack (alignment: .leading, spacing: 8) {
                    Text(self.game.name ?? "NO NAME!")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
    }
}


struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(game: game_demo)
        
    }
}





