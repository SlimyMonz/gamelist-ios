//
//  WebView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//

import SwiftUI
import WebKit
import Foundation

struct WebView: UIViewRepresentable {
    
    let url = URL(string: "https://my-game-list-front.herokuapp.com/games")
    
    func makeUIView(context: Context) -> some UIView {
        
        let webView = WKWebView()
        
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
}


