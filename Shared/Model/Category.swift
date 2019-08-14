//
//  Category.swift
//  Artable
//
//  Created by Juan Chavez on 7/15/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imageUrl: String
    var isActive: Bool = true
    var timestamp: Timestamp
    
    init(data: [String : Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
}
