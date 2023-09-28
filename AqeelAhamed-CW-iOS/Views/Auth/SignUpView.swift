//
//  SignUpView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed 2023-09-24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)
                .font(.system(size: 15))
                .textFieldStyle(OutlinedTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
                .shadow(radius: 1.0)
                .frame(height: 40)
                .textInputAutocapitalization(.never)
            
            TextField("Email", text: $viewModel.email)
                .font(.system(size: 15))
                .textFieldStyle(OutlinedTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
                .shadow(radius: 1.0)
                .frame(height: 40)
                .textInputAutocapitalization(.never)
                .padding(.top,10)
            
            SecureField("Password", text: $viewModel.password)
                .font(.system(size: 15))
                .textFieldStyle(OutlinedTextFieldStyle())
                .font(.headline)
                .cornerRadius(10)
                .shadow(radius: 1.0)
                .frame(height: 40)
                .textInputAutocapitalization(.never)
                .padding(.top,10)
            
            Button(action: {viewModel.signUp() }) {
                Text("Sign Up")
            }   .frame(width: 320, height: 40)
                .font(.system(size: 15))
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 30)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorText)
                    );
                }
            HStack {
                Spacer()
                Button("Already have an account? Sign In!") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 12))
                .bold()
                .cornerRadius(10)
                .shadow(radius: 10) 
                Spacer()
                
            }.padding(.top,20)
        }
        .padding()
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
