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
        
        setUpHomePage()
        //configureUserLocation()
        FirebaseApp.configure()
        
        return true
    }

    /// Request the needed access from the user in order to use the user'slocation
//    fileprivate func configureUserLocation(){
//
//        self.locationManager = CLLocationManager()
//        self.locationManager.delegate = self as? CLLocationManagerDelegate
//
//        // Configuring User Location
//        if (CLLocationManager.locationServicesEnabled())
//        {
//            self.locationManager = CLLocationManager()
//            self.locationManager.delegate = self as? CLLocationManagerDelegate
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            self.locationManager.requestAlwaysAuthorization()
//            self.locationManager.startUpdatingLocation()
//        }
//    }
    
    fileprivate func setUpHomePage(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let controller = HomePageViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        
    }
    
}

