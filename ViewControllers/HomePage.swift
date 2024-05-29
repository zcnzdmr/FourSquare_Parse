//
//  HomaPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit

class HomePage: UIViewController {
    
    var collectionView : UICollectionView!
    var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUIs()
    }
    
    
    func collectionViewFonk() {
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        var layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .vertical
        layOut.sectionInset = UIEdgeInsets(top: 140, left: 1, bottom: 1, right: 1)
        layOut.minimumInteritemSpacing = 0
        layOut.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 140, width: screenWidth, height: screenHeight), collectionViewLayout: layOut)
        
    }
    
    private func setUPUIs() {
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
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
