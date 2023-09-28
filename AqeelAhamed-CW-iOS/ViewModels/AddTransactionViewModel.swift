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
    

    @Published var transaction = TransactionModel(id: "", title: "", amount: "", transactionType: "Income", category: CategoryItem(id: 1, name: "", budget: ""), createdAt: Date(), note: "", location: UserLocation(lat: 0.0, long: 0.0))
    
    @Published var amount = ""
    @Published var occuredOn = Date()
    @Published var note = ""
    @Published var typeTitle = "Income"
    @Published var tagTitle = ""
    @Published var selectedTransactionType = "Income"
    @Published var selectedCategory = CategoryItem(id: 1, name: "", budget: "0")
    @Published var showTypeDrop = false
    @Published var showTagDrop = false
    @Published var errorText: String = ""
    @Published var showAlert: Bool = false
    
    
}
