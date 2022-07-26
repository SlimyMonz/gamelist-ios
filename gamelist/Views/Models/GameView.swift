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
                            Image("placeholder-cover")
                                .resizable()
                                .scaledToFit()
                                .background()
                        } .progressViewStyle(.linear)
                    }
                )
            
            Text("Game ID: " + game.id)
                .font(.footnote).padding(.bottom)
            Text("Overall Rating: " + (game.rating ?? "N/A"))
            Text("User Rating: " + (game.userRating ?? "0"))
            Text("Description: " + (game.description ?? "N/A"))
        }
        .navigationTitle(self.game.name ?? "").navigationBarTitleDisplayMode(.inline).padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: game_demo)
    }
}

