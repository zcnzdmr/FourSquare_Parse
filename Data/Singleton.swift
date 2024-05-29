//
//  Singleton.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 29.05.2024.
//

import Foundation
import UIKit

class Singleton {
    
    static let sharedInstance = Singleton()
    
    var name = String()
    var type = String()
    var comment = String()
    var latitude = Double()
    var longitude = Double()
    var imagem = UIImage()
    
    private init() {}
    
}
