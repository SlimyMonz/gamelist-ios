//
//  MyListPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//



import SwiftUI

struct MyListPage: View {
    
    @StateObject var search = userlistAPI(id: Mem.dm.id, token: Mem.dm.token)
    @ObservedObject var vm = ListViewModel()
    
    
    var body: some View {
        
        VStack{
            
            Text("Tap to search.")
                .foregroundColor(.blue)
                .fontWeight(.semibold)
                .onTapGesture {
                   
                    search.getUserList{ [self](list) in
                        self.vm.removeGames()
                        self.vm.addGames(list: list)
                    }
                    
                }
            ListView(vm: vm, platform: "Search")
        }
    }
}

struct MyListPage_Previews: PreviewProvider {
    static var previews: some View {
        MyListPage()
    }
}
