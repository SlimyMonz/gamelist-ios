//
//  decoder.swift
//  gamelist
//
//  Created by Harry Hocker on 7/18/22.
//

import Foundation

func decode_jwt(jwt: String) -> String
{
    let parts = jwt.components(separatedBy: ".")
    
    let body = parts[1]
    
    let base64 = base64url_to_base64(base64url: body)
    guard let payload = base64Decoded(base64: base64) else { return "-1" }
        
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

func base64Decoded(base64: String) -> String?
{
        guard let data = Data(base64Encoded: base64) else { return nil }
        return String(data: data, encoding: .utf8)
}


