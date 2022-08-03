//
//  constants.swift
//  gamelist
//
//  Created by Harry Hocker on 7/18/22.
//

import Foundation

let game_demo = GAME(id: "12345", name: "test game", description: "", cover: "//images.igdb.com/igdb/image/upload/t_thumb/co23nc.jpg", userRating: "3", platforms: ["xbox", "pc"], genres: ["shooty", "funny"])

enum Constant
{
    static let base_url = "https://my-game-list-front.herokuapp.com/api/"
    static let login_url = "users/login/"
    static let register_url = "users/register/"
    static let game_url = "games/searchAllGames/"
    static let userlist_url = "games/getUserGames/"
    static let email_url = "email/sendVerification/"
    static let reset = "email/passwordReset/"
    
    static let xsx = "Xbox Series X|S"
    static let xbone = "Xbox One"
    static let x360 = "Xbox 360"
    static let ps5 = "PlayStation 5"
    static let ps4 = "PlayStation 4"
    static let ps3 = "PlayStation 3"
    static let wii = "Wii"
    static let ninswitch = "Nintendo Switch"
    static let pc = "PC"
    static let mobile = "Mobile"
}

