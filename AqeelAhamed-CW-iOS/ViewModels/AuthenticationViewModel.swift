//
//  AuthenticationViewModel.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed 2023-09-24.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

class AuthenticationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var errorText: String = ""
    @Published var showAlert: Bool = false
    @Published var user: LocalUser
    @Published var modified = false
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(user: LocalUser = LocalUser(name: "", email: "")) { // (2)
        self.user = user
        
        self.$user // (3)
            .dropFirst() // (5)
            .sink { [weak self] user in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { [unowned self] (_, error) in
            if let error = error {
                errorText = "Please check the login credentials"
                showAlert = true;
            } else {
                state = .signedIn
            }
        }
    }
    
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
            if let error = error {
                self.errorText = "Please check the data and try again"
                self.showAlert = true;
            } else {
                do {
                    let localUser = LocalUser(name: self.name, email: self.email)
                    let _ = try self.db.collection("users").addDocument(from: localUser)
                    self.state = .signedIn
                }
                catch {
                    self.errorText = "Please check the data and try again"
                    self.showAlert = true;
                }
            }
        }
        
    }
    
    func addUser(_ user: LocalUser) {
        
        
        func signOut() {
            // 1
            //   GIDSignIn.sharedInstance.signOut()
            
            do {
                // 2
                try Auth.auth().signOut()
                
                state = .signedOut
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

