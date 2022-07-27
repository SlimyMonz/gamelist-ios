//
//  RegisterPage.swift
//  gamelist
//
//  Created by Harry Hocker on 7/13/22.
//


import SwiftUI

struct RegisterPage : View {
    
    @State var email: String = ""
    @State var first_name: String = ""
    @State var last_name: String = ""
    
    @State var username: String = ""
    @State var password: String = ""
    @State var confirm_password: String = ""
    
    @StateObject var reg = registerAPI()
    
    @ObservedObject var dmv = Mem.dm
    
    @State var reg_pressed = false
    @State var valid_input = true
    
    
    var body: some View {
        
        VStack () {

            
            Form {
                Section(header: Text("PROFILE")) {
                    TextField("Username", text: $username)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirm_password)
                }
                
                Section(header: Text("Info")) {
                    TextField("First Name", text: $first_name)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Last Name", text: $last_name)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                if (!valid_input){
                    Text("Invalid input!")
                        .foregroundColor(.red)
                }
            }
            
            Button(action: {
                
                if (registerLogic1(
                    usr: self.username,
                    psw: self.password,
                    cfp: self.confirm_password)
                    &&
                    registerLogic2(
                        fsn: first_name,
                        lsn: last_name,
                        em: email))
                {
                    reg.setInfo(user: username, pass: password, first: first_name, last: last_name, email: email)
                    reg.sendData()
                    reg_pressed = true
                } else {
                    valid_input = false
                }
                
                
            }) {
                DoRegisterButton()
            }
            .alert("Check your email!", isPresented: $reg_pressed) {
                Button("Ok", role: .cancel) {}
            }
            .navigationTitle(Text("Register"))
        }
    }
}


struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}


struct DoRegisterButton: View {
    var body: some View {
        Text("Register")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 60)
            .background(.green.opacity(0.85))
            .cornerRadius(15.0)
    }
}


func registerLogic1(usr: String, psw: String, cfp: String) -> Bool {
    
    if (usr.isEmpty) { return false }
    if (psw.isEmpty || cfp.isEmpty) { return false }
    if (psw != cfp) { return false }

    return true
}

func registerLogic2(fsn: String, lsn: String, em: String) -> Bool {
    
    if (fsn.isEmpty) { return false }
    if (lsn.isEmpty) { return false }
    if (em.isEmpty) { return false }
    if (!em.contains("@")) { return false }
    
    return true
}
