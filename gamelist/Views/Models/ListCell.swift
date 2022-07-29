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
            
            HStack {
                
                if (self.game.userRating != nil) {
                    Text(gameRateCheck(rating:(self.game.userRating ?? "")))
                        .font(.title)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .colorInvert()
                        .padding(5)
                        .background(getColor(rating: (self.game.userRating ?? "0")))
                        .cornerRadius(10)
                        .frame(width: 50)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    Text(self.game.name ?? "NO NAME!")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                }
            }
        }
    }
}


struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(game: game_demo)
        
    }
}


func getColor(rating: String) -> Color {
    
    let r = Int(rating) ?? 0
    
    switch (r) {
    case (8...10):  return .green
    case (6..<8):  return .yellow
    case (4..<6): return .orange
    case (1..<4): return .red
    default: return .secondary
    }
    
}



