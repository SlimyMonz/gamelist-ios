//
//  LoginPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/6/22.
//

import SwiftUI

struct LoginPage : View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @StateObject var vm = loginAPI()
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        
            VStack {
                
                Text("PLACEHOLDER TEXT: IMAGE GOES HERE")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom, 50.0)
                
                // replace the text with an image
                    
                TextField("Username", text: $username)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                HStack{
                    Button(action: {
                        vm.setInfo(username: username, password: password)
                        vm.getData()
                        // need to add code that does a check for login
                    }) {
                        LoginButton()
                    }
                    NavigationLink(destination: RegisterPage(), label: {
                        RegisterButton()
                    })
                }.padding()
            }.navigationTitle(Text("Login")).padding().navigationBarTitleDisplayMode(.automatic).offset(y: keyboardResponder.currentHeight * 0.1)
    }
    
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}


struct LoginButton: View {
    var body: some View {
        Text("Login")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct RegisterButton: View {
    var body: some View {
        Text("Register")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 60)
            .background(Color.red)
            .cornerRadius(15.0)
    }
}




