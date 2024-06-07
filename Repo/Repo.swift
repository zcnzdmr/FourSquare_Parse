//
//  Repo.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 29.05.2024.
//

import Foundation
import Parse
import RxSwift
import UIKit

class Repo {
    
    var listOfPlaces = BehaviorSubject(value: [PFObject]())
    
    
    func signUpFonk(email:String,password:String) {
        
        let user = PFUser()
        
        user.username = email
        user.password = password
        
        user.signUpInBackground { success, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "sth went wrong while signing up")
                let notCentName2 = NSNotification.Name("kayit hatasi")
                NotificationCenter.default.post(name:notCentName2 , object: nil)
            }else {
                
                let notCentName = NSNotification.Name("kayit tamamlandi")
                NotificationCenter.default.post(name:notCentName , object: nil)
            }
        }
    }
    
    func signInFonk(email:String,password:String) {
        
        PFUser.logInWithUsername(inBackground: email, password: password) { user, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "singin In error")
            }else{
                print("welcome")
                let notCentName3 = NSNotification.Name("giriş yapıldı")
                NotificationCenter.default.post(name:notCentName3 , object: nil)
            }
        }
    }
    
    
    // MARK: Parse Veri kaydetme
    func saveData(name:String,type:String,comment:String,latitude:Double,longitude:Double, image: UIImage) {
        
        let uuid = UUID().uuidString
        
        let parseObject = PFObject(className: "FavoritePlaces") // Önce PF objesi oluşturuyoruz bu bir class.
        
        // Daha sonra sözlük yapısını kullanarak kolon isimlerini parantez içinde verip değerleri karşısına yazıyoruz.
        parseObject["name"]      = name
        parseObject["type"]      = type
        parseObject["comment"]   = comment
        parseObject["latitude"]  = latitude
        parseObject["longitude"] = longitude
        
        if let imagedata = image.pngData() {
            parseObject["image"] = PFFileObject(name: "\(uuid).jpeg", data: imagedata)
        }
        let group = DispatchGroup()
        
        // en son asenkron şekilde çalışan saveInBackground olan fonk ile kayıt işlemini gerçekleştiriyoruz.
        parseObject.saveInBackground { success, error in
            group.enter()
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }else{
                print("başarılı")
                group.leave()
                self.getData()
            }
        }
    }
    
    // MARK: Parse Verileri Çekme Kısmı
    func getData() {
        
        // Önce bir PF query oluşturup verilerini çekeceğimiz sınıfın ismini veriyoruz.
        let query = PFQuery(className: "FavoritePlaces")
        
        
        // Eğer spesifik olarak belli kolondan belli değerleri çekmek istersek yani filtreleyerek çekmek istersek burda where fonk yardımımıza koşuyor.
        //        query.whereKey(<#T##key: String##String#>, lessThan: <#T##Any#>)
        //        query.whereKey(<#T##key: String##String#>, equalTo: <#T##Any#>)
        //        query.whereKey(<#T##key: String##String#>, contains: <#T##String?#>) gibi fonk.'lar burda kolon ismini key'e yazıp karşısına istediğimiz değeri yazıyoruz.
        
        // burada genel olarak bize [PFObjects]? array i vereni seçiyoruz bu tüm kolonları içeriyor.
        query.order(byAscending: "createdAt")
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error pullings records")
            }else{
                if let pfObjects = objects {
                    
                    self.listOfPlaces.onNext(pfObjects)

                }
            }
        }
    }
}
