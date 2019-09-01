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
        guard
            let navigationViewController = window?.rootViewController as? UINavigationController,
            let homeViewController = navigationViewController.topViewController as? HomeViewController
        else { fatalError("Unexpected root view controller") }

        let httpClient = HTTPClient(isStubbed: false)
        let userRepository = UserRepository(client: httpClient)
        let interactor = RecommendationsInteractor(userRepository: userRepository)
        let homeReactor: HomeReactor = HomeReactor(interactor: interactor)
        homeViewController.reactor = homeReactor
        

        return true
    }

}

