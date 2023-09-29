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

enum FilterByDate: String {
    case all
    case week
    case month
}

class DashboardViewModel: ObservableObject,Identifiable {
    
    @Published var user: LocalUser
    @Published var firebaseUser: User?
    
    @Published var modified = false
    @Published var isNoTransactions = true
    @Published var errorText: String = ""
    @Published var showAlert: Bool = false
    @Published var navBudget: Bool = false
    @Published var totalBudget: TotalBudget = TotalBudget(budget: "")
    @Published var transactions = [TransactionModel]()
    @Published var income: String = ""
    @Published var expense: String = ""
    private var listenerRegistration: ListenerRegistration?
    private var listenerRegistrationExpenses: ListenerRegistration?
    @Published var filter: FilterByDate = .all
    
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
        
        if listenerRegistrationExpenses != nil {
            listenerRegistrationExpenses?.remove()
            listenerRegistrationExpenses = nil
        }
        
    }
    
    func getDateByFilter() -> Date{
        switch filter {
        case .all:
            return Date().getLastLongDay()!
        case .week:
            return Date().getLast7Day()!
        case .month:
            return Date().getLast30Day()!
        default:
            return Date().getLastLongDay()!
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
        
        db.collection("transations").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).whereField("createdAt",isGreaterThan: getDateByFilter() ).order(by: "createdAt", descending: true).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                self.isNoTransactions = true
                return
            }
      
            self.transactions = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: TransactionModel.self)
            }
            
            
            var incomeTotal = 0.0
            var expenseTotal = 0.0
            
            for item in self.transactions {
                if(item.transactionType == "Income"){
                    incomeTotal += Double(item.amount)!
                }else{
                    expenseTotal +=  Double(item.amount)!
                }
            }
            self.income = "\(incomeTotal)"
            self.expense = "\(expenseTotal)"
            self.isNoTransactions = false
        }
        
    }
    
}



