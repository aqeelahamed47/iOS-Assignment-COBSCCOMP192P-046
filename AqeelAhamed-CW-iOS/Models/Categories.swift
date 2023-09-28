//
//  Categories.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-26.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Codable {
    @DocumentID var id: String?
    var categories:[CategoryItem]
   
    
    enum CodingKeys: String, CodingKey {
        case id
        case categories
    }
}


struct CategoryItem: Identifiable, Codable {
    var id: Int
    var name: String
    var budget: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case budget
    }
}
