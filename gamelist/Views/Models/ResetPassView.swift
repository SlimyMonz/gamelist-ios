//
//  ResetPassView.swift
//  gamelist
//
//  Created by Harry Hocker on 7/28/22.
//

import SwiftUI

struct ResetPassView: View {
    
    @State var email_input = ""
    
    
    var body: some View {
        
        
        VStack {
            TextField("Enter email", text: $email_input)
                .padding()
                .background(.quaternary)
                .cornerRadius(15)
                
            
            Button {
                print("ay")
            } label: {
                Text("Send Email")
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding()
                    .background(.green)
                    .cornerRadius(10)
                    .font(.title)
            }
            .padding(.top, 100)

        }
        .padding()
        .padding(.bottom, 100)
        .navigationTitle("Forgot Email")
    }
        
}

struct ResetPassView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassView()
    }
}

