//
//  DetailPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit
import MapKit

class DetailPage: UIViewController {
    
    var imageViewm = UIImageView()
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var mapKit = MKMapView()
    
    var name: String?
    var type : String?
    var comment : String?
    var image : Data?
    var latitude : Double?
    var longitude : Double?
    
    init(name: String, type: String, comment: String, image: Data, latitude: Double, longitude: Double) {
        super.init(nibName: nil, bundle: nil)
        
        self.name = name
        self.type = type
        self.comment = comment
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIsDetail()
        mapKitFonk()
        titleFonk()

        // Do any additional setup after loading the view.
    }
    
    func titleFonk() {
        self.navigationItem.title = "Detail Page"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Papyrus", size: 25)!,
                                                                        NSAttributedString.Key.foregroundColor : UIColor.systemGray]
    }
    
    private func setUpUIsDetail() {
        
        let screenWidth = view.frame.size.width
        view.backgroundColor = .systemBackground
        
        imageViewm.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 250)
        imageViewm.layer.borderWidth = 0.7
        imageViewm.clipsToBounds = true
        imageViewm.image = UIImage(data: self.image!)
        view.addSubview(imageViewm)
        
        
        label1.frame = CGRect(x: 20, y: 370, width: (screenWidth - 40) , height: 40)
        label1.layer.borderWidth  = 0.6
        label1.layer.cornerRadius = 10
        label1.layer.borderColor = UIColor.systemGray.cgColor
        label1.textAlignment = .center
        label1.text = self.name
        view.addSubview(label1)
        
        label2.frame = CGRect(x: 20, y: 430, width: (screenWidth - 40) , height: 40)
        label2.layer.borderWidth  = 0.6
        label2.layer.cornerRadius = 10
        label2.layer.borderColor = UIColor.systemGray.cgColor
        label2.textAlignment = .center
        label2.text = self.type
        view.addSubview(label2)
        
        
        label3.frame = CGRect(x: 20, y: 490, width: (screenWidth - 40) , height: 40)
        label3.layer.borderWidth  = 0.6
        label3.layer.cornerRadius = 10
        label3.layer.borderColor = UIColor.systemGray.cgColor
        label3.textAlignment = .center
        label3.text = self.comment
        view.addSubview(label3)
         
    }
    
    func mapKitFonk() {
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        if let latitudeX = self.latitude , let longitudeX = self.longitude {
            
            mapKit.frame = CGRect(x: 0, y: 560, width: screenWidth, height: screenHeight - 560)
            mapKit.layer.cornerRadius = 15
            mapKit.layer.borderWidth = 0.7
            let location = CLLocationCoordinate2D(latitude: latitudeX, longitude: longitudeX)
            let span  = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            mapKit.setRegion(region, animated: true)
            view.addSubview(mapKit)
            
            let pin = MKPointAnnotation()
            
            pin.coordinate = location
            pin.title = self.name
            pin.subtitle = self.type
            mapKit.addAnnotation(pin)
        }
    }
}
