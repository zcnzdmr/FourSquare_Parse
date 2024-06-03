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
        
//        let singIn = UINavigationController(rootViewController: SignIn())
//        let homePage = UINavigationController(rootViewController: HomePage())
//        
//        let currentUser = PFUser.current()
//        
//        if currentUser != nil {
//            window?.rootViewController = singIn
//        }else {
//            window?.rootViewController = homePage
//        }
//        window?.rootViewController = singIn
        
        let nav = UINavigationController()
        
        let mainView = SignInViewController(nibName: nil, bundle: nil)
        let mainView2 = HomePage(nibName: nil, bundle: nil)
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            nav.viewControllers = [mainView2]
            window?.rootViewController = nav
        }else{
            nav.viewControllers = [mainView]
            window?.rootViewController = nav
        }
        
        window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
