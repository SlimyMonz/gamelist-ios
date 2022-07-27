//
//  AppData.swift
//  gamelist
//
//  Created by Harry Hocker on 7/20/22.
//

import Foundation
import SwiftUI

let defaults = UserDefaults.standard

struct DK
{
    static let username = "username"
    static let password = "password"
    static let id = "id"
    static let token = "token"
    static let verified = "verified"
}


struct Mem {
    static let dm = DataMemory()
}



class DataMemory: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    
    @Published var id = ""
    @Published var token = ""
    
    @Published var verified = false
    @Published var registered = false
    
    @Published var firstName = ""
    @Published var lastName = ""
    
    @Published var email = ""
}

