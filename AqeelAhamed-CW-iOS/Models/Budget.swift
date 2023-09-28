//
//  Budget.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-26.
//

import Foundation
import FirebaseFirestoreSwift

struct Budget: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var step: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case step
    }
}

struct BudgetItem: Identifiable, Codable {
    var id: Int?
    var category: CategoryItem
    var budget: String
    
    enum CodingKeys: String, CodingKey {
        case category
        case budget
    }
}


struct TotalBudget: Identifiable, Codable {
    @DocumentID var id: String?
    var budget: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case budget
    }
}
