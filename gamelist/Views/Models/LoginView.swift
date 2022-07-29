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
    
    @ObservedObject var dmv = Mem.dm
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    @State var login_pressed = false
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                
                WelcomeImage()
                    .padding(.bottom)
                    
                TextField("Username", text: $username)
                    .padding()
                    .background(.quaternary)
                    .cornerRadius(5.0)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.quaternary)
                    .cornerRadius(5.0)
                    .padding(.bottom, 50)
                
                HStack {
                    Button(action: {
                        vm.setInfo(username: username, password: password)
                        vm.getData()
                        login_pressed = true
                    }) {
                        LoginButton()
                    }
                    
                    NavigationLink {
                        RegisterPage()
                    } label: {
                        RegisterButton()
                    }
                    
                }
                
                NavigationLink("Forgot Password?", destination: ResetView())
                    .padding(.top)
                
                
                .padding(.bottom, 50)
            }.navigationTitle(Text("Login")).padding().offset(y: keyboardResponder.currentHeight * 0.2)
        }
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
            .background(.green.opacity(0.75))
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
            .background(.red.opacity(0.75))
            .cornerRadius(15.0)
    }
}

struct WelcomeImage: View {
    var body: some View {
        ZStack {
            Image("mygamelist-icon")
                .resizable()
                .scaledToFit()
                .padding(25)
                .cornerRadius(50)
            
        }
    }
}


