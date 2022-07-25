//
//  GameView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/25/22.
//

import SwiftUI

struct GameView: View {
    
    let game: GAME
    
    var body: some View {
        
        ScrollView{
            
                AsyncImage(
                    url: URL(string: game.cover ?? ""),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                    },
                    placeholder: {
                        ProgressView(){
                            Image("default-icon")
                                .resizable()
                                .scaledToFit()
                                .background()
                        } .padding().progressViewStyle(.linear)
                    }
                )
            
            Text(game.id)
            Text(game.name ?? "name")
            Text(game.description ?? "description")
            Text(game.rating ?? "rating")
            Text(game.userRating ?? "user rating")
        }
        .navigationTitle(self.game.name ?? "").navigationBarTitleDisplayMode(.inline)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: game_demo)
    }
}

