//
//  AppData.swift
//  gamelist
//
//  Created by Harry Hocker on 7/20/22.
//

import Foundation
import SwiftUI

let defaults = UserDefaults.standard

struct DK {
    
    static let username = "username"
    static let id = "id"
    static let token = "token"
    static let verified = "verified"

}



class DataMemory: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    
    @Published var id = ""
    @Published var token = ""
    @Published var verified = false
    
    init() {
        if let id = defaults.string(forKey: DK.id) {
            self.id = id
        }
        if let token = defaults.string(forKey: DK.token) {
            self.token = token
        }
        
        self.verified = defaults.bool(forKey: DK.verified)
        
    }
    
    
    
}

