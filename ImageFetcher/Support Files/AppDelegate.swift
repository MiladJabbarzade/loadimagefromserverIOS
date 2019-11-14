//
//  AppDelegate.swift
//  ImageFetcher
//
//  Created by meelad jabbarzade on today.
//  Copyright © 2019 meelad jabbarzade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        let photoLoader = ImageFetcherController(collectionViewLayout: UICollectionViewFlowLayout())
        let navController = UINavigationController(rootViewController: photoLoader)
        self.window?.rootViewController = navController
        
        return true
    }
}

