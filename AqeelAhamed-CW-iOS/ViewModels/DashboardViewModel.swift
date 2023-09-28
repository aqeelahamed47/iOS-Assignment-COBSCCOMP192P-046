//
//  DashboardViewModel.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

class DashboardViewModel: ObservableObject {
    
    @Published var user: LocalUser
    @Published var firebaseUser: User?
    
    @Published var modified = false
    @Published var errorText: String = ""
    @Published var showAlert: Bool = false
    @Published var navBudget: Bool = false
    @Published var totalBudget: TotalBudget = TotalBudget(budget: "")
    
    private var listenerRegistration: ListenerRegistration?
    
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
    }
    
    func getUserFromFirebase() {
        db.collection("users").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            guard let document = try? querySnapshot!.data(as: LocalUser.self) else {
                print("No documents")
                return
            }
            self.user = document
            if(document.step == 1){
                self.navBudget = true
            }
        }
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("totalBudget").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
                guard let document = try? querySnapshot!.data(as: TotalBudget.self) else {
                    print("No documents")
                    return
                }
                self.totalBudget = document
            }
        }
    }
    
}

