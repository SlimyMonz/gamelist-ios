//
//  KeyboardResponder.swift
//  gamelist
//
//  Created by Harry Hocker on 7/6/22.
//

import Foundation
import SwiftUI

class KeyboardResponder: ObservableObject {
    
    @objc func keyBoardWillShow(notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                withAnimation {
                   currentHeight = keyboardSize.height
                }
            }
        }
    @objc func keyBoardWillHide(notification: Notification) {
            withAnimation {
               currentHeight = 0
            }
        }
    
    @Published var currentHeight: CGFloat = 0
    
    var _center: NotificationCenter
        init(center: NotificationCenter = .default) {
            _center = center

//4. Tell the notification center to listen to the system keyboardWillShow and keyboardWillHide notification
            _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
}

