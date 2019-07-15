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
}
