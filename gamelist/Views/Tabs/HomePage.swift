//
//  HomePage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import SwiftUI

struct HomePage: View {
    
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                ConsoleSearchView(platform: Constant.ps5)
                
                ConsoleSearchView(platform: Constant.xsx)
                
                ConsoleSearchView(platform: Constant.ps4)
                
                ConsoleSearchView(platform: Constant.xbone)
                
                ConsoleSearchView(platform: Constant.ps3)
                
            }
            .navigationTitle("Consoles")
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}


struct ConsoleSearchView: View {
    
    let search = searchAPI()
    let platform: String
    
    @ObservedObject var vm = ListViewModel()
    
    init(platform: String) {
        
        self.platform = platform
        self.search.setPlatform(platform: platform)
        search.getGameList { [self](list) in
            self.vm.removeGames()
            self.vm.addGames(list: list)
        }
    }
    
    var body: some View {
        
        VStack {
            
            NavigationLink {
                ListView(vm: vm, platform: platform)
            } label: {
                    
                    Image(self.platform + "-icon")
                        .resizable()
                        .scaledToFit()
                        .background()
                
            }
            Text(self.platform)
                .font(.headline)
        }
        .padding()
    }
}
