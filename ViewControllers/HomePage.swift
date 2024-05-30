//
//  HomaPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit
import Parse
import RxSwift

class HomePage: UIViewController {
    
    var collectionViewm : UICollectionView!
    var searchBar = UISearchBar()
    var ViewModelNesnesi = HomeVM()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUIs()
        collectionViewFonk()
        titleForHomePage()
        barButonFonk()
    }
    
    func veriCekme() {
        _ = ViewModelNesnesi.listOfPlaces.subscribe(onNext: { liste in
            DispatchQueue.main.async {
                self.collectionViewm.reloadData()
            }
        })
        
    }
    
    
    private func titleForHomePage() {
        
        navigationItem.backButtonTitle = "Back"
        self.navigationItem.title = "HomePage"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Papyrus", size: 25)!,
                                                                        NSAttributedString.Key.foregroundColor : UIColor.systemGray]
    }
    
    private func barButonFonk() {
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let rightButon = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(passToRegisterPage))
        rightButon.tintColor = .black
        navigationItem.rightBarButtonItem = rightButon
    }
    
    @objc func passToRegisterPage() {
        self.show(RegisterPage(), sender: nil)
    }

    
    func collectionViewFonk() {
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .vertical
        layOut.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layOut.minimumInteritemSpacing = 1
        layOut.minimumLineSpacing = 1
        
        collectionViewm = UICollectionView(frame: CGRect(x: 0, y: 140, width: screenWidth, height: screenHeight), collectionViewLayout: layOut)
        collectionViewm.register(CollectCell.self, forCellWithReuseIdentifier: "hucrem")
        collectionViewm.delegate = self
        collectionViewm.dataSource = self
        collectionViewm.layer.borderWidth = 0.6
        view.addSubview(collectionViewm)
        
        
    }
    
    private func setUPUIs() {
        
        let screenWidth = view.frame.size.width
        
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 40)
        searchBar.placeholder = "Enter What you look for"
        view.addSubview(searchBar)
    }

}

extension HomePage : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension HomePage : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hucrem", for: indexPath) as! CollectCell
        
        cell.imageViewm.image = UIImage(named: "Bart")
//        cell.layer.borderWidth = 0.9
        cell.cellLabel.text = "Restaurantlar "
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = view.frame.size.width
        
        return CGSize(width: (screenWidth - 3) / 2 , height: 180)
    }
    
}
