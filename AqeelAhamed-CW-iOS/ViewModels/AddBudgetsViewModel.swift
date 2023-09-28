//
//  AddBudgetsViewModel.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

class AddBudgetViewModel: ObservableObject {
    
    @Published var user: LocalUser
    @Published var categories: Category = Category(categories: [])
    
    @Published var errorText: String = ""
    @Published var showAlert: Bool = false
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(user: LocalUser = LocalUser(name: "", email: "",step:0)) { // (2)
        self.user = user
        
        self.$user // (3)
            .dropFirst() // (5)
            .sink { [weak self] user in
            }
            .store(in: &self.cancellables)
    }
    
    func addData(completion: @escaping CompletionHandler) {
        do {
            var totalPrice = 0.0
            for item in categories.categories {
                totalPrice +=  Double(item.budget)!
            }
            let _ = try self.db.collection("categories").document(Auth.auth().currentUser!.uid).setData(from: categories)
            let total = TotalBudget(budget: "\(totalPrice)")
            let _ = try self.db.collection("totalBudget").document(Auth.auth().currentUser!.uid).setData(from: total)
            
            user.step = 2
            
            let _ = try self.db.collection("users").document(Auth.auth().currentUser!.uid).setData(from: user)
            completion(true)
        }
        catch {
            self.errorText = "Please check the data and try again"
            self.showAlert = true;
        }
    }
    
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("categories").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
                guard let document = try? querySnapshot!.data(as: Category.self) else {
                    print("No documents")
                    return
                }
                self.categories = document
            }
        }
    }
    
    func getUserFromFirebase() {
        db.collection("users").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            guard let document = try? querySnapshot!.data(as: LocalUser.self) else {
                print("No documents")
                return
            }
            self.user = document
            
        }
    }

    
    
}

