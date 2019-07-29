//
//  Product.swift
//  Artable
//
//  Created by Juan Chavez on 7/29/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name: String
    var id: String
    var category: String
    var price: Double
    var productDescription: String
    var imageUrl: String
    var timestamp: Timestamp
    var stock: Int
    var favorite: Bool
}
