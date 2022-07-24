//
//  decoder.swift
//  gamelist
//
//  Created by Harry Hocker on 7/18/22.
//

import Foundation

func decode_jwt(jwt: String) -> USER?
{
    let parts = jwt.components(separatedBy: ".")
    
    let body = parts[1]
    
    let base64 = base64url_to_base64(base64url: body)
    guard let jsondata = base64Decoded(base64: base64) else { return nil }
    let payload = decode_JSON(json: jsondata)
    
    return payload
}

func base64url_to_base64(base64url: String) -> String
{
    var base64 = base64url
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    if base64.count % 4 != 0 {
        base64.append(String(repeating: "=", count: 4 - base64.count % 4))
    }
    return base64
}

func base64Decoded(base64: String) -> Data?
{
        let payload = Data(base64Encoded: base64)
        return payload
}

func decode_JSON(json: Data) -> USER
{
    do {
        let data = try JSONDecoder().decode(JSON.self, from: json)
        return data.user[0]
    } catch {
        return USER(id: "-1", verified: false, username: "")
    }
}




