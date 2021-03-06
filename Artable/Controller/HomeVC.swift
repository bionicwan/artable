//
//  ViewController.swift
//  Artable
//
//  Created by Juan Chavez on 5/24/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    var categories = [Category]()
    var selectedCategory: Category!
    var db : Firestore!
    var listener : ListenerRegistration!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error)
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchDocument()
        //fetchCollection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.listener.remove()
    }
    
    func setCategoriesListener() {
        listener = db.collection("categories").addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let category = Category.init(data: data)
                
                switch change.type {
                case.added:
                    self.onDocumentAdded(change: change, category: category)
                case.modified:
                    self.onDocumentModified()
                case.removed:
                    self.onDocumentRemoved()
                }
            })
            
            
        })
    }
    
    func onDocumentAdded(change: DocumentChange, category: Category) {
        let newIndex = Int(change.newIndex)
        self.categories.insert(category, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    
    func onDocumentModified() {
        
    }
    
    func onDocumentRemoved() {
        
    }
    
    /*func fetchCollection() {
        let collectionRef = db.collection("categories")
        self.listener = collectionRef.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else { return }
            self.categories.removeAll()
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            
            self.collectionView.reloadData()
        }
        
        
        /*collectionRef.getDocuments { (snap, error) in
            guard let documents = snap?.documents else { return }
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            
            self.collectionView.reloadData()
        }*/
    }
    
    func fetchDocument() {
        let docRef = db.collection("categories").document("zfdUDnlOvBu1EXXqSMhX")
        
        self.listener = docRef.addSnapshotListener { (snap, error) in
            guard let data = snap?.data() else { return }
            self.categories.removeAll()
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
        }
        
        /*docRef.getDocument { (snap, error) in
            guard let data = snap?.data() else { return }
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
            
        }*/
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        setCategoriesListener()
        if let user = Auth.auth().currentUser , !user.isAnonymous {
            //We are logged in
            loginOutBtn.title = "Logout"
        } else {
            loginOutBtn.title = "Login"
        }
    }
    
    @IBAction func loginOutClicked(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        debugPrint(error)
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                    }
                    
                    self.presentLoginController()
                }
            } catch {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
            }
        }
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 26) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.toProducts, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toProducts {
            if let destination = segue.destination as? ProductsVC {
                destination.category = selectedCategory
            }
        }
    }
}
