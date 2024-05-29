//
//  RegisterVM.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 29.05.2024.
//

import Foundation
import UIKit

class MapeVM {
    
    var repoNesnesi = Repo()
    
    init() {
        print("init çalıştı")
    }
    
    func saveData(name:String,type:String,comment:String,latitude:Double,longitude:Double, image: UIImage) {
        repoNesnesi.saveData(name: name, type: type, comment: comment,latitude: latitude, longitude: longitude, image: image)
    }
}
