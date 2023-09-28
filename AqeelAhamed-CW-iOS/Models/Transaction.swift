//
//  Transaction.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-28.
//

import Foundation
import FirebaseFirestoreSwift

struct TransactionModel: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var amount: String
    var transactionType: String
    var category: CategoryItem
    var createdAt: Date
    var note: String
    var location: UserLocation
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case amount
        case transactionType
        case category
        case createdAt
        case note
        case location
    }
}

struct UserLocation: Identifiable, Codable {
    @DocumentID var id: String?
    var lat: Double
    var long: Double
     
    
    enum CodingKeys: String, CodingKey {
        case lat
        case long
    }
}
