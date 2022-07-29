//
//  constants.swift
//  gamelist
//
//  Created by Harry Hocker on 7/18/22.
//

import Foundation

let game_demo = GAME(id: "12345", name: "test game", description: "not a real game", cover: "//images.igdb.com/igdb/image/upload/t_thumb/co23nc.jpg", rating: "8", userRating: "3")

enum Constant
{
    static let base_url = "https://my-game-list-front.herokuapp.com/"
    static let login_url = "api/users/login/"
    static let register_url = "api/users/register/"
    static let game_url = "api/games/searchAllGames"
    static let userlist_url = "api/games/getUserGames"
    static let email_url = "api/email/sendVerification"
    
    static let xsx = "Xbox Series X"
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

struct GAME: Decodable, Identifiable
{
    let id: String
    let name: String?
    let description: String?
    let cover: String?
    let rating: String?
    let userRating: String?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "_id"
        case name = "name"
        case description = "description"
        case cover = "image"
        case rating = "rating"
        case userRating = "personalRating"
    }
}



struct JWT: Decodable
{
    let token: String
    
    enum CodingKeys: String, CodingKey
    {
        case token = "token"
    }
}

struct JSON: Decodable
{
    let user: [USER]
    
    enum CodingKeys: String, CodingKey
    {
        case user = "user"
    }
}

struct USER: Decodable
{
    let id: String
    let verified: Bool
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "_id"
        case verified = "verified"
        case username = "userName"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
    }
}

struct REGISTER: Decodable
{
    let message: String
    let id: String
    let email: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey
    {
        case message = "message"
        case id = "userId"
        case email = "email"
        case firstName = "firstName"
    }
}
