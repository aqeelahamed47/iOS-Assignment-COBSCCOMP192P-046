//
//  LoginView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed 2023-09-24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    @State private var navSignup: Bool =  false
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $viewModel.password)       .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                    .padding(.top,10)
                Button(action: {viewModel.signIn() }) {
                    Text("Sign in")
                }   .frame(width: 320, height: 40)
                    .font(.system(size: 15))
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 30)  .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(viewModel.errorText)
                        );
                    }
                HStack {
                    Spacer()
                    
                    Button("Dont have an account? Sign up!") {
                        print("presssed")
                        navSignup = true
                    }
                    .font(.system(size: 12))
                    .bold()
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    
                    Spacer()
                    
                }.padding(.top,20)
            }.navigationDestination(
                isPresented: $navSignup) {
                    SignUpView()
                }
            
            .padding()
        }
    }
}

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
