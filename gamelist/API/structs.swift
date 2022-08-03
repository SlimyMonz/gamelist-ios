//
//  structs.swift
//  gamelist
//
//  Created by Harry Hocker on 8/2/22.
//

import Foundation


struct GAME: Decodable, Identifiable
{
    let id: String
    let name: String?
    let description: String?
    let cover: String?
    let userRating: String?
    let platforms: [String]?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "_id"
        case name = "name"
        case description = "description"
        case cover = "image"
        case userRating = "personalRating"
        case platforms = "platforms"
        case genres = "genres"
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
