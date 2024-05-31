//
//  HomaPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit
import Parse
import RxSwift
import Kingfisher

class HomePage: UIViewController {
    
    var collectionViewm : UICollectionView!
    var searchBar = UISearchBar()
    var ViewModelNesnesi = HomeVM()
    var pfObjectList = [PFObject]()
    var nameList = [String]()
    var imageList = [Data]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUPUIs()
        collectionViewFonk()
        titleForHomePage()
        barButonFonk()
        veriCekme()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        ViewModelNesnesi.getData()
//    }
    
    func veriCekme() {
        
        ViewModelNesnesi.listOfPlaces
//            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { /*[weak self] */liste in
//                guard let self = self else { return }
                self.pfObjectList = liste
                
                self.nameList.removeAll()
                self.imageList.removeAll()
                
                let group = DispatchGroup()

                for i in self.pfObjectList {
                    
                    if let nameVariable = i["name"] as? String {
                        self.nameList.append(nameVariable)
                        print(nameVariable)
                    }
                    
                    if let imageVariable = i["image"] as? PFFileObject {
                        group.enter()
                        imageVariable.getDataInBackground { data, error in
                            if let data = data {
                                self.imageList.append(data)
                                print(self.imageList.count)
                            } else {
                                print(error?.localizedDescription ?? "Error while pulling image data")
                            }
                            group.leave()
                        }
                    }
                }

                group.notify(queue: .main) {
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
        return nameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hucrem", for: indexPath) as! CollectCell
        
        let name = nameList[indexPath.row]
        
        cell.imageViewm.image = UIImage(data: imageList[indexPath.row])
        cell.cellLabel.text = name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = view.frame.size.width
        
        return CGSize(width: (screenWidth - 3) / 2 , height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
}
