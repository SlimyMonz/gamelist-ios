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
    @Published var register_page = false
    @Published var registered = true
    
    @Published var firstName = ""
    @Published var lastName = ""
    
    init() {
        if let id = defaults.string(forKey: DK.id) {
            self.id = id
        }
        if let token = defaults.string(forKey: DK.token) {
            self.token = token
        }
        self.verified = false
    }
}

