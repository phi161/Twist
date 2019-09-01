//
//  AppDelegate.swift
//  Twist
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let homeViewController = window?.rootViewController as? HomeViewController else { fatalError("Unexpected root view controller") }
        
        return true
    }

}

