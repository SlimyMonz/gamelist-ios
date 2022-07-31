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

            VStack {

                AsyncImage(
                    url: URL(string: "https:" + (game.cover ?? "")),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .greatestFiniteMagnitude)
                            .padding(.horizontal)
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
                    .font(.footnote)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Platforms").font(.headline)
                        ForEach(game.platforms ?? [""], id: \.self) { platform in
                            Text(platform).multilineTextAlignment(.leading)
                        }
                    }.frame(maxWidth: .infinity)
                    
                    VStack(alignment: .trailing) {
                        Text("Genres").font(.headline)
                        ForEach(game.genres ?? [""], id: \.self) { platform in
                            Text(platform).multilineTextAlignment(.trailing)
                        }
                    }.frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity).padding(.vertical)
                
                if (game.description != ""){
                    Text("Description: ")
                        .font(.headline)
                    Text(game.description ?? "").padding(.horizontal)
                }
            }
        }
        .navigationTitle(self.game.name ?? "").navigationBarTitleDisplayMode(.inline).padding()
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: game_demo)
    }
}

func gameRateCheck(rating: String) -> String {
    if (rating == "") {return "?"}
    return rating
}
