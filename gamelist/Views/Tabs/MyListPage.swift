//
//  MyListPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//



import SwiftUI

struct MyListPage: View {
    

    var body: some View {
        ListView(title: "User List", isUserList: true)
    }
}

struct MyListPage_Previews: PreviewProvider {
    static var previews: some View {
        MyListPage()
    }
}
