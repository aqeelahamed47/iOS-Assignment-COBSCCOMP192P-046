//
//  ViewTransactionViewModel.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-29.
//

import Foundation


class ViewTransactionViewModel:ObservableObject{
    
    @Published var transaction :TransactionModel
    
    init(transaction: TransactionModel) {
        self.transaction = transaction
    }
}
