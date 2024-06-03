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
    var typeList = [String]()
    var commentList = [String]()
    var imageList = [Data]()
    var latitudeList = [Double]()
    var longitudeList = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUPUIs()
        collectionViewFonk()
        titleForHomePage()
        barButonFonk()
        veriCekme()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            ViewModelNesnesi.getData()
        }
    
//    func veriCekme() {
//        
//        ViewModelNesnesi.listOfPlaces.subscribe(onNext: { liste in
//            
//                self.pfObjectList = liste
//                
//                self.nameList.removeAll()
//                self.imageList.removeAll()
//                self.commentList.removeAll()
//                self.typeList.removeAll()
//                self.latitudeList.removeAll()
//                self.longitudeList.removeAll()
//                
//                let group = DispatchGroup()
//                
//                for i in self.pfObjectList {
//                    group.enter()
//                    if let nameVariable = i["name"] as? String {
//                        self.nameList.append(nameVariable)
//                    }
//                    
//                    if let imageVariable = i["image"] as? PFFileObject {
//                        imageVariable.getDataInBackground { data, error in
//                            if let data = data {
//                                self.imageList.append(data)
//                            } else {
//                                print(error?.localizedDescription ?? "Error while pulling image data")
//                            }
//                            group.leave()
//                        }
//                    }
//                    
//                    if let commentVariable = i["comment"] as? String {
//                        self.commentList.append(commentVariable)
//                    }
//                    
//                    if let typeVariable = i["type"] as? String {
//                        self.typeList.append(typeVariable)
//                    }
//                    
//                    if let latitudeVariable = i["latitude"] as? Double {
//                        self.latitudeList.append(latitudeVariable)
//                    }
//                    
//                    if let longitudeVariable = i["longitude"] as? Double {
//                        self.longitudeList.append(longitudeVariable)
//                    }
//                    
//                }
//                
//                group.notify(queue: .main) {
//                    self.collectionViewm.reloadData()
//                }
//            })
//    }
    
    func veriCekme() {
        ViewModelNesnesi.listOfPlaces
            .subscribe(onNext: { [weak self] liste in
                guard let self = self else { return }
                self.pfObjectList = liste
                
                self.nameList.removeAll()
                self.imageList.removeAll()
                self.commentList.removeAll()
                self.typeList.removeAll()
                self.latitudeList.removeAll()
                self.longitudeList.removeAll()
                
                let group = DispatchGroup()
                
                for i in self.pfObjectList {
                    group.enter()
                    
                    var nameVariable: String?
                    var commentVariable: String?
                    var typeVariable: String?
                    var latitudeVariable: Double?
                    var longitudeVariable: Double?
                    
                    if let name = i["name"] as? String {
                        nameVariable = name
                    }
                    
                    if let comment = i["comment"] as? String {
                        commentVariable = comment
                    }
                    
                    if let type = i["type"] as? String {
                        typeVariable = type
                    }
                    
                    if let latitude = i["latitude"] as? Double {
                        latitudeVariable = latitude
                    }
                    
                    if let longitude = i["longitude"] as? Double {
                        longitudeVariable = longitude
                    }
                    
                    if let imageVariable = i["image"] as? PFFileObject {
                        imageVariable.getDataInBackground { data, error in
                            if let data = data {
                                self.nameList.append(nameVariable ?? "")
                                self.imageList.append(data)
                                self.commentList.append(commentVariable ?? "")
                                self.typeList.append(typeVariable ?? "")
                                self.latitudeList.append(latitudeVariable ?? 0)
                                self.longitudeList.append(longitudeVariable ?? 0)
                            } else {
                                print(error?.localizedDescription ?? "Error while pulling image data")
                            }
                            group.leave()
                        }
                    } else {
                        group.leave()
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
        
        let leftButon = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(passToSignIn))
        leftButon.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButon
    }
    
    @objc func passToRegisterPage() {
        self.show(RegisterPage(), sender: nil)
    }
    
    @objc func passToSignIn() {
        self.show(SignInViewController(), sender: nil)
    }
    
    func passToDetail(name: String, type: String, comment: String, image: Data, latitude: Double, longitude: Double) {
        self.navigationController?.pushViewController(DetailPage(name: name, type: type, comment: comment, image: image, latitude: latitude, longitude: longitude), animated: true)
    }
    
    
    func collectionViewFonk() {
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        
        // MARK: Navigation Controller ve statusBar yüksekliğini veren kodlar
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 44 // Default navigation bar height
        
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height ---> bu eski kod statusBar yüksekliğini veren
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let navContHeight = navBarHeight + statusBarHeight
        print(navContHeight)
        
        // MARK: CollectionView , Flow'un ve itemlar arası boşluğun ayarlanma kısmı
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .vertical
        layOut.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layOut.minimumInteritemSpacing = 1
        layOut.minimumLineSpacing = 1
        
        collectionViewm = UICollectionView(frame: CGRect(x: 0, y: 138, width: screenWidth, height: screenHeight), collectionViewLayout: layOut)
        collectionViewm.register(CollectCell.self, forCellWithReuseIdentifier: "hucrem")
        collectionViewm.delegate = self
        collectionViewm.dataSource = self
//        collectionViewm.layer.borderWidth = 0.6
        view.addSubview(collectionViewm)
        
    }
    
    
    private func setUPUIs() {
        
        let screenWidth = view.frame.size.width
        
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 98, width: screenWidth, height: 40)
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
        
        let nameX = nameList[indexPath.row]
        let typeX = typeList[indexPath.row]
        let commentX = commentList[indexPath.row]
        let imageX = imageList[indexPath.row]
        let latitudeX = latitudeList[indexPath.row]
        let longitudeX = longitudeList[indexPath.row]
        
        self.passToDetail(name: nameX, type: typeX, comment: commentX, image: imageX, latitude: latitudeX, longitude: longitudeX)
        
    }
}
