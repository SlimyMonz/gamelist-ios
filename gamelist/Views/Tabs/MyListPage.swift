//
//  MyListPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//



import SwiftUI

struct MyListPage: View {
    
    @ObservedObject var dvm = Mem.dm
    @ObservedObject var search = userlistAPI()
    @ObservedObject var vm = ListViewModel()
    
    init() {
        search.setUser(id: dvm.id, token: dvm.token)
        self.search.getUserList{ [self](list) in
            self.vm.removeGames()
            self.vm.addGames(list: list)
        }
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                ListView(vm: vm, platform: dvm.firstName + "'s List")
            }
        }
    }
}

struct MyListPage_Previews: PreviewProvider {
    static var previews: some View {
        MyListPage()
    }
}
