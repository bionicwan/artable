//
//  ProductCell.swift
//  Artable
//
//  Created by Juan Chavez on 7/29/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    
    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Product) {
        productTitle.text = product.name
        //productPrice.text = product.price
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
    }
    
}
