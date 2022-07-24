//
//  constants.swift
//  gamelist
//
//  Created by Harry Hocker on 7/18/22.
//

import Foundation

enum Constant
{
    static let base_url = "https://my-game-list-front.herokuapp.com/"
    static let login_url = "api/users/login/"
    static let register_url = "api/users/register/"
    static let game_url = "api/games/searchAllGames"
}

struct GAME: Decodable, Identifiable
{
    let id: String
    let name: String
    let description: String
    let cover: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case description = "description"
        case cover = "cover"
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
    
    enum CodingKeys: String, CodingKey
    {
        case id = "_id"
        case verified = "verified"
    }
}


