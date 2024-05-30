//
//  HomeVM.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 30.05.2024.
//

import Foundation
import Parse
import RxSwift

class HomeVM {
    
    var listOfPlaces = BehaviorSubject(value:[PFObject]())
    var repoNesnesi = Repo()
    
    init() {
        self.listOfPlaces = repoNesnesi.listOfPlaces
        getData()
    }
    
    func getData() {
        repoNesnesi.getData()
    }
    
}
