//
//  ViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import CoreLocation
import Foundation
import NVActivityIndicatorView
import UIKit

class HomePageViewController: UIViewController, CLLocationManagerDelegate{

    // - MARK: Properties & UI Elements
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .lightGray
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    var customAlertView: CustomAlertView = {
        let view = CustomAlertView(title: "Unable To Connect", message: "Please check your connection and try again.")
        return view
    }()
    
    
    static var loadingIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    
    var spaces = [Space](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // - MARK: VIEW CONTROLLER LIFECYCLE METHODS
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        getUserCoordinates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        configureLoadingIndicator()
        setUpNavigationBarItems()
        monitorInternetConnectivity()
        
    }
    
    
    // - MARK: CLASS METHODS
    
    /// Sets up the loading indicator in the center of the screen when data are being fetched
    private func configureLoadingIndicator() {
        
        var frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 50, height: 50)
        HomePageViewController.loadingIndicator = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: .darkGray, padding: 0)
        HomePageViewController.loadingIndicator.startAnimating()
        HomePageViewController.loadingIndicator.center = view.center
        view.addSubview(HomePageViewController.loadingIndicator)
    }
    
    
    /// Propmt the user to grant access to the device's current location
    private func getUserCoordinates(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    /// Checks if the user if the user is connected to the internet. Show an alert when they aren't
    private func monitorInternetConnectivity() {
        
        NetworkReachabilityServices.shared.reachability.whenUnreachable = { reachability in
            if reachability.connection == .none || (reachability.connection != .wifi && reachability.connection != .cellular) {
                DispatchQueue.main.async {
                    self.customAlertView.present(animated: true)
                }
            }
        }

        NetworkReachabilityServices.shared.reachability.whenReachable = { reachability in
            if reachability.connection == .wifi || reachability.connection == .cellular {

                DispatchQueue.main.async {
                    self.customAlertView.dismiss(animated: true)
                }
            }
        }
        
    }
    
    /// Make API request to fetch nearby spaces based on the user coordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        SpaceServices.shared.fetchAllSpaces(longitude: locValue.longitude, latitude: locValue.latitude) { (result) in
            
            switch result{
            case let .success(fetchedSpaces):
                self.spaces = fetchedSpaces.sorted(by: { $0.distance ?? 0.0 < $1.distance ?? 0.0 })
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    /// Sets up home page title and nav bar items
    private func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = "Explore Nearby Spaces"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0
    }
    
    /// Uses contraint to layout the collection view on top of the main view.
    private func anchorCollectionView(){
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }

}
