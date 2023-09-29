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
    @Published var firebaseUser: User?
    private var handle: AuthStateDidChangeListenerHandle?
    
    @Published var modified = false
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        unsubscribe()
    }
    
    init(user: LocalUser = LocalUser(name: "", email: "",step:0)) { // (2)
        self.user = user
        
        self.$user // (3)
            .dropFirst() // (5)
            .sink { [weak self] user in
                self?.modified = true
            }
            .store(in: &self.cancellables)
        
        if(Auth.auth().currentUser != nil){
            state = .signedIn
            firebaseUser = Auth.auth().currentUser
        }
    }
    
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { [unowned self] (_, error) in
            if let _ = error {
                errorText = "Please check the login credentials"
                showAlert = true;
            } else {
                state = .signedIn
                firebaseUser = Auth.auth().currentUser
            }
        }
    }
    
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
            if let _ = error {
                self.errorText = "Please check the data and try again"
                self.showAlert = true;
            } else {
                do {
                    let localUser = LocalUser(id:authResult?.user.uid,name: self.name, email: self.email,step: 1)
                    let categories = Category(id:authResult?.user.uid, categories: [CategoryItem(id: 1, name: "Food",budget: "0"),CategoryItem(id: 2, name: "Travel",budget: "0"),CategoryItem(id: 3, name: "Life style",budget:"0"),CategoryItem(id: 4, name: "Bills",budget: "0")])
                    
                    let _ = try self.db.collection("users").document(authResult!.user.uid).setData(from: localUser)
                    let _ = try self.db.collection("categories").document(authResult!.user.uid).setData(from: categories)
                    
                    self.state = .signedIn
                    self.firebaseUser = Auth.auth().currentUser
                }
                catch {
                    self.errorText = "Please check the data and try again"
                    self.showAlert = true;
                }
            }
        }
        
    }
    
    func unsubscribe() {
        if handle != nil {
            handle = nil
        }
    }
    
    func subscribe() { 
        if handle == nil {
            handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
                if let userdata = user {
                    print(userdata.uid)
                } else {
                    self.state = .signedOut
                }
            })
            
        }
    }
    
    
    func signOut() { 
        do {
            // 2
            try Auth.auth().signOut()
            
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

