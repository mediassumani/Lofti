//
//  NetworkReachabilityServices.swift
//  Lofti
//
//  Created by Medi Assumani on 3/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import Reachability

class NetworkReachabilityServices: NSObject{
    /* Implements The Functionality for the device's network status
     
     Methods :
     - networkStatusChanged : updates and notfies status changes
     - stopNotifier - stops the notifier
     - isReachable ; can connect to internet
     - isUnReachable : cannot connect to internet
     - isReachableViaCellular : can connect to internet via cellullar
     - isReachableViaWifi : can connect to internet via wifi
     
     */
    
    var reachability: Reachability!
    static let shared = NetworkReachabilityServices()
    
    override init() {
        super.init()
        
        reachability = Reachability()!
        
        // Registers an observer for the network status
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(networkStatusChanged(_:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        
        // Booting up the notifier after initilizing the object
        do {
            try? reachability.startNotifier()
        } catch {
            
            print("Error Found : Unable to start notifier")
        }
        
    }
    
    //updates and notfies internet status changes
    @objc func networkStatusChanged(_ notification: Notification) {
        
    }
    
    // Stops the notifier from broadcasting
    static func stopNotifier(){
        do{
            try? NetworkReachabilityServices.shared.reachability.stopNotifier()
        } catch {
            print("Error Found : Error found while stopping Notifier")
        }
    }
    
    // Handles connetion status when it is unreachable altogether
    static func isUnReachable(completion: @escaping (NetworkReachabilityServices, Bool) -> ()) {
        
        if NetworkReachabilityServices.shared.reachability.connection == .none{
            completion(NetworkReachabilityServices.shared, true)
        }else{
            completion(NetworkReachabilityServices.shared, false)
        }
    }
    
    static func isReachable(completion: @escaping(NetworkReachabilityServices, Bool) -> ()){
        if NetworkReachabilityServices.shared.reachability.connection != .none{
            completion(NetworkReachabilityServices.shared, true)
        } else {
            completion(NetworkReachabilityServices.shared, false)
        }
    }
    
    // Handles connetion status when it is reachable via wwan or cellular(phone data)
    static func isReachableViaCellular(completion: @escaping (NetworkReachabilityServices, Bool) -> ()) {
        if NetworkReachabilityServices.shared.reachability.connection == .cellular{
            completion(NetworkReachabilityServices.shared, true)
        }else{
            completion(NetworkReachabilityServices.shared, false)
        }
    }
    
    // Handles connetion status when it is reachable via wifi
    static func isReachableViaWifi(completion: @escaping (NetworkReachabilityServices, Bool) -> ()){
        if NetworkReachabilityServices.shared.reachability.connection == .wifi{
            completion(NetworkReachabilityServices.shared, true)
        }else{
            completion(NetworkReachabilityServices.shared, false)
        }
    }
}
