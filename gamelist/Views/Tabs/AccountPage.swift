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
                Text(dvm.username)
                Text(dvm.firstName)
                Text(dvm.lastName)
                Text(dvm.id)
                
                Text("Logout")
                    .onTapGesture{dvm.verified = false}
                    .foregroundColor(.red)
                    .padding()
                
            }
        }
        .onAppear(perform:{
            print("hey")
        })
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}


