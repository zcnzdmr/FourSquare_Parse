//
//  DetailPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit

class DetailPage: UIViewController {
    
    var name: String?
    var type : String?
    var comment : String?
    var image : UIImage?
    var latitude : Double?
    var longitude : Double?
    
    init(name: String, type: String, comment: String, image: UIImage, latitude: Double, longitude: Double) {
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
