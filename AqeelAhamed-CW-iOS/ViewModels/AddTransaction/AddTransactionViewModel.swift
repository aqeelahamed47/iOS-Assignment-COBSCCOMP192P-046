//
//  AddTransactionViewModel.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-28.
//

import Foundation
import Firebase
import FirebaseFirestore

class AddTransactionViewModel: ObservableObject {
    

    @Published var transaction = TransactionModel(id: "", userId: "", title: "", amount: "", transactionType: "Income", category: CategoryItem(id: 1, name: "", budget: ""), createdAt: Date(), note: "", location: UserLocation(lat: 0.0, long: 0.0))
    
    private var db = Firestore.firestore()
    
    @Published var allCategories = Category(categories: []) 
    @Published var showTypeDrop = false
    @Published var showTagDrop = false
    @Published var alertMsg: String = ""
    @Published var showAlert: Bool = false
    @Published var categoryDropdowns: [DropdownOption] = []
    @Published var tagTitle: String = ""
    
    func getCategories() {
        
        db.collection("categories").document(Auth.auth().currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            guard let document = try? querySnapshot!.data(as: Category.self) else {
                print("No documents")
                return
            }
            
            self.allCategories = document
            let firstItem = document.categories.first
            
            self.tagTitle = firstItem?.name ?? ""
            self.transaction.category = firstItem!
            
            for item in document.categories {
                self.categoryDropdowns.append(DropdownOption(key: "\(item.id)", val: item.name))
            }
        }
    }
    
    func addData(completion: @escaping CompletionHandler) {
        do {
            
            if transaction.title.isEmpty || transaction.title == "" {
                alertMsg = "Enter Title"; showAlert = true
                return
            }
            if transaction.amount.isEmpty || transaction.amount == "" {
                alertMsg = "Enter Amount"; showAlert = true
                return
            }
            guard let amount = Double(transaction.amount) else {
                alertMsg = "Enter valid number"; showAlert = true
                return
            }
            guard amount >= 0 else {
                alertMsg = "Amount can't be negative"; showAlert = true
                return
            }
           
            transaction.userId = Auth.auth().currentUser!.uid
            transaction.id = UUID().uuidString
            let index = allCategories.categories.firstIndex{$0.id == transaction.category.id}!
            
            if(transaction.transactionType == "Income"){
                allCategories.categories[index].budget = "\(Double(allCategories.categories[index].budget)! + Double(transaction.amount)!)"
                
            }else{
                allCategories.categories[index].budget = "\(Double(allCategories.categories[index].budget)! - Double(transaction.amount)!)"
                
            }
            
            var totalPrice = 0.0
            for item in allCategories.categories {
                totalPrice +=  Double(item.budget)!
            }
            let _ = try self.db.collection("categories").document(Auth.auth().currentUser!.uid).setData(from: allCategories)
            let total = TotalBudget(budget: "\(totalPrice)")
            let _ = try self.db.collection("totalBudget").document(Auth.auth().currentUser!.uid).setData(from: total)
            let _ = try self.db.collection("transations").addDocument(from: transaction)
            
        
            completion(true)
        }
        catch {
            self.alertMsg = "Please check the data and try again"
            self.showAlert = true;
        }
    }
}
