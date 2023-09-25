//
//  LocalUser.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed 2023-09-24.
//

import Foundation
import FirebaseFirestoreSwift

struct LocalUser: Identifiable, Codable {
  @DocumentID var id: String?
  var name: String
  var email: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case email
  }
}
