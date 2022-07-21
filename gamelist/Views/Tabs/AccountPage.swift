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
        
        
        if (dvm.verified) {
            // run code to grab user info like name etc
        }
        
        NavigationView {
            VStack {
                Text(dvm.username)
                Text(dvm.firstName)
                Text(dvm.lastName)
                Text(dvm.id)
            }
        }
                
        
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
