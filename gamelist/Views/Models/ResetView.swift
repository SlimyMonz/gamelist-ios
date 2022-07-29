//
//  ResetPassView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/28/22.
//

import SwiftUI

struct ResetView: View {
    
    @State var email_input = ""
    @State var valid_email = false
    @State var invalid_email = false
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        
        VStack {
            TextField("Enter email for password reset", text: $email_input)
                .padding()
                .background(.quaternary)
                .cornerRadius(15)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            
            Button {
                print("ay")
            } label: {
                Text("Reset Password")
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding()
                    .background(.green)
                    .cornerRadius(10)
                    .font(.title)
                    .onTapGesture {
                        if (validEmail(email: email_input)) {
                            resetPassword(email: email_input)
                            valid_email = true
                        } else {
                            invalid_email = true
                        }
                    }
            }
            .alert("Check your email!", isPresented: $valid_email) {
                Button("Ok", role: .cancel) {}
            }
            .alert("Invalid email!", isPresented: $invalid_email){
                Button("Ok", role: .cancel) {}
            }
            .padding(.top, 100)
            
        }
        .padding()
        .padding(.bottom)
        .navigationTitle("Reset Password").offset(y: keyboardResponder.currentHeight * 0.2)
    }
}

struct ResetPassView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
    }
}

func validEmail(email: String) -> Bool {
    
    if (email.contains("@") && (!email.isEmpty)) {
        return true
    }
    
    return false
}
