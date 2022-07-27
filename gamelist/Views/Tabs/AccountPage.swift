//
//  AccountPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import SwiftUI

struct AccountPage: View {
    
    @ObservedObject var dvm = Mem.dm
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Text("Username:")
                    .padding(.top, 300)
                CTextField(dvm.username)
                    .padding(.bottom)
                Text("Name: ")
                HStack {
                    CTextField(dvm.firstName)
                    CTextField(dvm.lastName)
                }.padding(.bottom)
                Text("Email: ")
                CTextField(dvm.email)
                    .padding(.bottom)
                
                Text("User ID: " + dvm.id)
                    .offset(y: 130)
                
                Text("Logout")
                    .foregroundColor(.red)
                    .padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.red, lineWidth: 2)
                    )
                    .padding(.top, 20)
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}


struct CTextField: View {

    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(.primary)
            .font(.headline)
    }
}
