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
                
                Image("mygamelist-icon")
                
                Text("Username:")
                    .padding(.top, 50)
                CTextField(dvm.username)
                    .padding(.bottom)
                Text("Name: ")
                HStack {
                    CTextField(dvm.firstName)
                    CTextField(dvm.lastName)
                }.padding(.bottom)
                Text("Email: ")
                CTextField(dvm.email)
                    .padding(.bottom, 100)
                
                Text("Logout")
                    .padding(25)
                    .background(.red)
                    .cornerRadius(25)
                    .foregroundColor(.primary)
                    .font(.headline)
                    .onTapGesture{
                        dvm.verified = false
                        dvm.email = ""
                        dvm.username = ""
                        dvm.firstName = ""
                        dvm.lastName = ""
                        dvm.id = ""
                        dvm.token = ""
                    }
                Text("User ID: " + dvm.id)
                
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
