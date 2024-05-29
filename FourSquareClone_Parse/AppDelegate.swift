//
//  AppDelegate.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let singIn = UINavigationController(rootViewController: SignIn())
        
        window?.rootViewController = singIn
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
