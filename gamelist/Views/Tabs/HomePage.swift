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
            
            VStack {
                
                ConsoleSearchView(platform: Constant.ps5)
                
                ConsoleSearchView(platform: Constant.ps4)
                
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


// figure out why the array is "bleeding" into each view

struct ConsoleSearchView: View {
    
    private let search = searchAPI()
    private let platform: String
    
    init(platform: String) {
        self.platform = platform
        self.search.setPlatform(platform: platform)
        self.search.doSearch()
    }
    
    var body: some View {
        NavigationLink {
            ListView(title: platform)
        } label: {
            Text("Tap to search.")
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            
        }
    }
}
