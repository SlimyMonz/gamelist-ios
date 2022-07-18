//
//  ContentView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    @State var selected_tab = 2
    
    var body: some View {
        
        TabView (selection: $selected_tab){
            MyListPage()
                .tabItem {
                    Label("My List", systemImage: "list.bullet")
                } .tag(1)
            
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                    
                } .tag(2)
            AccountPage()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                } .tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
