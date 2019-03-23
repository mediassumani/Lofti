//
//  NetworkReachabilityServices.swift
//  Lofti
//
//  Created by Medi Assumani on 3/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import Reachability

class NetworkReachabilityServices: NSObject {
    
    typealias IsDeviceConnected = (_ isConnected: Bool) -> ()
    var reachability = Reachability()!
    static let shared = NetworkReachabilityServices()
    
    override init() {
        super.init()
        
        setUpReachabilityNotifier()
        
    }
    
    
    private func setUpReachabilityNotifier() {
       
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(connectionStatusHasChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
    }
    
    @objc func connectionStatusHasChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Reachable via wifi")
        case .cellular:
            print("Reachable via cellular")
        case .none:
            print("Unreachable")
            
        }
    }
    
    static func stopNotifier() {
        NetworkReachabilityServices.shared.reachability.stopNotifier()
    }
    
    static func checkDeviceConnection(completion: IsDeviceConnected) {
        
        let connection = NetworkReachabilityServices.shared.reachability.connection
        if connection == .cellular || connection == .wifi {
            completion(true)
        } else {
            completion(false)
        }
    }
    
}
