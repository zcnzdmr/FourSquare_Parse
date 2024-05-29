//
//  Repo.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 29.05.2024.
//

import Foundation
import Parse

class Repo {
    
    
    // MARK: Parse Veri kaydetme
    func saveData(name:String,type:String,comment:String,latitude:Double,longitude:Double, image: UIImage) {
        
        let parseObject          = PFObject(className: "Placess") // Önce PF objesi oluşturuyoruz bu bir class.
        
        // Daha sonra sözlük yapısını kullanarak kolon isimlerini parantez içinde verip değerleri karşısına yazıyoruz.
        parseObject["name"]      = name
        parseObject["type"]      = type
        parseObject["comment"]   = comment
        parseObject["latitude"]  = latitude
        parseObject["longitude"] = longitude
        
        parseObject["image"]     = image
        
        // en son asenkron şekilde çalışan saveInBackground olan fonk ile kayıt işlemini gerçekleştiriyoruz.
        parseObject.saveInBackground { success, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }else{
                print("başarılı")
            }
        }
    }
    
    // MARK: Parse Verileri Çekme Kısmı
    func getData() {
        
        // Önce bir PF query oluşturup verilerini çekeceğimiz sınıfın ismini veriyoruz.
        let query = PFQuery(className: "Placess")
        

        // Eğer spesifik olarak belli kolondan belli değerleri çekmek istersek yani filtreleyerek çekmek istersek burda where fonk yardımımıza koşuyor.
//        query.whereKey(<#T##key: String##String#>, lessThan: <#T##Any#>)
//        query.whereKey(<#T##key: String##String#>, equalTo: <#T##Any#>)
//        query.whereKey(<#T##key: String##String#>, contains: <#T##String?#>) gibi fonk.'lar burda kolon ismini key'e yazıp karşısına istediğimiz değeri yazıyoruz.
        
        // burada genel olarak bize [PFObjects]? array i vereni seçiyoruz bu tüm kolonları içeriyor.
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error pullings records")
            }else{
                
            }
            
            
        }
        
    }
    
    

}
