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


struct USER: Codable, Identifiable
{
    let id: String
    
    let firstName: String?
    let lastName: String?
    
    let username: String?
    let email: String?
    
    let verified: Bool?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "_id"
        
        case firstName = "firstName"
        case lastName = "lastName"
        
        case username = "userName"
        case email = "email"
        
        case verified = "verified"
    }
}



