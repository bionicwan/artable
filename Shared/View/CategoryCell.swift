//
//  CategoryCell.swift
//  Artable
//
//  Created by Juan Chavez on 7/15/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 5
    }
    
    func configureCell(category: Category) {
        categoryLabel.text = category.name
        if let url = URL(string: category.imageUrl) {
            categoryImage.kf.setImage(with: url)
        }
    }

}
