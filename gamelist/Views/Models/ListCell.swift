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
        
        
        VStack (alignment: .leading, spacing: 8) {
            Text(self.game.name ?? "NO NAME!")
                .fontWeight(.semibold)
                .lineLimit(1)
        }
    }
}


struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(game: game_demo)
        
    }
}




let game_demo = GAME(id: "12345", name: "test game", description: "not a real game", cover: nil, rating: "5", userRating: "0")
