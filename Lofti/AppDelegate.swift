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
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkIfFirstTimeUser()
        FirebaseApp.configure()
        
        return true
    }
    
    /// Check and route the user to the proper page based on if they are a first time user
    private func checkIfFirstTimeUser(){
        
        let isCurrentUser = UserDefaults.standard.bool(forKey: "current_user")
        
        if isCurrentUser{

            showHomePage()
            
        }else{
            
            UserDefaults.standard.set(false, forKey: "current_user")
            showOnboardingPage()
        }
    }
    
    /// Display the onboarding page for first time user
    private func showOnboardingPage(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window{
            
            let destinationVC = OnboardingCollectionViewController(collectionViewLayout: layout)
            window.rootViewController = destinationVC
            window.makeKeyAndVisible()
        }
    }

    /// Render the home page when the app launch
    private func showHomePage(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = HomePageViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
    }
    
    /// Show the page for the user to choose their preferences
    public func showUserPreferencesPage(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .vertical
        let controller = UserPreferencesViewController(collectionViewLayout: layoutFlow)
        let navigationController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
}

