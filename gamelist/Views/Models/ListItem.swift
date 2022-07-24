//
//  ListItem.swift
//  gamelist
//
//  Created by Harry Hocker on 7/24/22.
//

import SwiftUI

struct ListItem: View {
    
    let name: String
    let description: String
    
    var body: some View {
       
        HStack(alignment: .center) {
                
                Image("mygamelist-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 75)
            VStack(alignment: .leading) {
                    Text(name)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    Text(description)
                        .multilineTextAlignment(.leading)
                }
                
            }
            .frame(maxWidth: .infinity)
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(name: "game title", description: "game description will go here omg lol akdjfaksdjf kafjdksfjadskj aksdjfadsj ")
            
    }
}


