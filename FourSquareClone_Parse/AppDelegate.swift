//
//  AppDelegate.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
 
           let configuration = ParseClientConfiguration {
               $0.applicationId = "FEP1tNiUToPnKPX7Ga1GTQ4GH3p98gmCVSs0X8OY"
              $0.clientKey = "rI3gL3xpZD2bgCVARh6nbJr6glJGMIvDdlOEORQu"
              $0.server = "https://parseapi.back4app.com/"
          }
        
        Parse.initialize(with: configuration)
        
        let singIn = UINavigationController(rootViewController: SignIn())
        
        window?.rootViewController = singIn
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
