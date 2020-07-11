//
//  AppDelegate.swift
//  TestApp
//
//  Created by rizky satria on 10/07/20.
//  Copyright © 2020 RizkySatria. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let isLogin = UserDefaults.standard.dictionary(forKey: Constant.KEY_LOGIN_USER) != nil
        
        if isLogin {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            setRootScreen(viewController: storyboard.instantiateViewController(withIdentifier: "MainTabbarController"))
        } else {
            let loginScreen = LoginViewController.create()
            setRootScreen(viewController: loginScreen)
        }
        
        return true
    }
    
    func setRootScreen(viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

}

