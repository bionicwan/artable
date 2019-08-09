//
//  ProductsVC.swift
//  Artable
//
//  Created by Juan Chavez on 7/29/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product = Product.init(name: "Landscape", id: "johojiohih", category: "Nature", price: 24.99, productDescription: "Lovely Landscape", imageUrl: "https://images.unsplash.com/photo-1536444640702-7d82b071cab8?ixlib=rb-1.2.1&auto=format&fit=crop&w=2468&q=80", timestamp: Timestamp(), stock: 0, favorite: false)
        products.append(product)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
    }


}

extension ProductsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
