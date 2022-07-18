//
//  gamelistApp.swift
//  gamelist
//
//  Created by Harry Hocker on 7/6/22.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let black = Color(red: 0, green: 0, blue: 0, opacity: 0.25)



@main
struct gamelistApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
