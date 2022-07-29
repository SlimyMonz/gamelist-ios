//
//  reset_email.swift
//  gamelist
//
//  Created by Harry Hocker on 7/29/22.
//

import SwiftUI


func resetPassword(email: String) {
    
    guard
        let url = URL(string: Constant.base_url + Constant.reset)
    else {

        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body = ["email": email]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200
        else {
            return
        }
        guard
            error == nil
        else {
            return
        }

    }.resume()
}
