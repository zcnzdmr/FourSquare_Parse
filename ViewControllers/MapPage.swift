//
//  MapPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapPage: UIViewController {
    
    var viewModelNesnesi = MapeVM()
    
    var mapKit = MKMapView()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapKitFonk()
        gesture()
        locationProperties()
        barButonFonk()
    }
    
    private func barButonFonk() {
        
        let saveButon = UIBarButtonItem(image: UIImage(systemName: "externaldrive.fill.badge.plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveData))
        saveButon.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = saveButon
        
    }
    
    @objc func saveData() {
        
        viewModelNesnesi.saveData(name: Singleton.sharedInstance.name,
                                  type: Singleton.sharedInstance.type,
                                  comment: Singleton.sharedInstance.comment,
                                  latitude: Singleton.sharedInstance.latitude,
                                  longitude: Singleton.sharedInstance.longitude,
                                  image: Singleton.sharedInstance.imagem
        )
        
        self.navigationController?.pushViewController(HomePage(), animated: true)
    }
    
    func locationProperties() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func gesture() {
        
        mapKit.isUserInteractionEnabled  = true
        let gR = UILongPressGestureRecognizer(target: self, action: #selector(generateAnnotation))
        gR.minimumPressDuration = 2
        mapKit.addGestureRecognizer(gR)
    }
    
    @objc func generateAnnotation(gesRec:UILongPressGestureRecognizer) {
        
        let annotation = MKPointAnnotation()
        
        let touchedLocation = gesRec.location(in: self.mapKit)
        let touchedCoordinate = mapKit.convert(touchedLocation, toCoordinateFrom: self.mapKit)
        
        Singleton.sharedInstance.latitude = touchedCoordinate.latitude
        Singleton.sharedInstance.longitude = touchedCoordinate.longitude
        
        annotation.coordinate = touchedCoordinate
        annotation.title = Singleton.sharedInstance.name
        annotation.subtitle = Singleton.sharedInstance.type
        
        mapKit.addAnnotation(annotation)
        
    }
    
    //    private func mapKitFonk() {
    //
    //        mapKit.frame = view.bounds
    //        let location = CLLocationCoordinate2D(latitude: 39.928674, longitude: 32.869978)
    //        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
    //        let region = MKCoordinateRegion(center: location, span: span)
    //        mapKit.setRegion(region, animated: true)
    //        view.addSubview(mapKit)
    ////        mapKit.delegate = self
    //    }
    //}
}

extension MapPage : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count-1]
        
        let latitudeUpdated = location.coordinate.latitude
        let longitudeUpdate = location.coordinate.longitude
        
        mapKit.frame = view.bounds
        let locationX = CLLocationCoordinate2D(latitude: latitudeUpdated, longitude: longitudeUpdate)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: locationX, span: span)
        mapKit.setRegion(region, animated: true)
        view.addSubview(mapKit)
        
    }
    
    
    
}
