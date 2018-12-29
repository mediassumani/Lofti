//
//  AppDelegate.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkIfFirstTimeUser()
        FirebaseApp.configure()
        
        return true
    }
    
    private func checkIfFirstTimeUser(){
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore{
            
            showHomePage()
            
        }else{
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            showUserPreferencesPage()
        }
    }

    private func showHomePage(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = HomePageViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
    }
    
    private func showUserPreferencesPage(){
     
        window = UIWindow(frame: UIScreen.main.bounds)
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .vertical
        let controller = UserPreferencesViewController(collectionViewLayout: layoutFlow)
        let navigationController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
    
    
}

