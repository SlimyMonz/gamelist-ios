//
//  ListItem.swift
//  gamelist
//
//  Created by Harry Hocker on 7/24/22.
//

import SwiftUI

struct ListCell: View {
    
    let name: String
    let description: String
    
    var body: some View {
        

            VStack (alignment: .leading, spacing: 8) {
                Text(self.name)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(self.description)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            
        }
   
    }
    


struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(name: "game title", description: "game description will go here omg lol akdjfaksdjf kafjdksfjadskj aksdjfadsj ")
        
    }
}


func getImage(platform: String) -> String {
    
    switch (platform){
        
    case "Xbox One" :
        return "xbox-icon"
        
    case "Playstation 4" :
        return "ps4-icon"
        
    case "PC" :
        return "pc-icon"
        
    default:
        return "game-icon"
    }
    
    
}
