//
//  ViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

protocol SpaceDelegate: class{
    func passSpaceData(space: Space?)
}

class HomePageViewController: UIViewController, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    var spaces = [Space](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        
        getUserCoordinates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        //getUserCoordinates()
        setUpNavigationBarItems()
    }
    
    
    fileprivate func getUserCoordinates(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let dispatchGroup = DispatchGroup()
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        SpaceServices.index(longitude: locValue.longitude, latitude: locValue.latitude) { (spaces) in
            
            spaces.forEach({ (space) in
                
                dispatchGroup.enter()
                GeoFence.addressToCoordinate("\(space.location.address1), \(space.location.city), \(space.location.state)", completion: { (coordinates) in
                    
                    guard let unwrappedCoordinates = coordinates else {return}
                    let userLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
                    let spaceLocation = CLLocation(latitude: unwrappedCoordinates.latitude, longitude: unwrappedCoordinates.longitude)
                    let distance = round((userLocation.distance(from: spaceLocation) / 1609.344) * 100) / 100
                    
                    space.distance = distance
                    space.latitude = unwrappedCoordinates.latitude
                    space.longitude = unwrappedCoordinates.longitude
                    self.spaces.append(space)
                    dispatchGroup.leave()
                })
                
            })
            dispatchGroup.notify(queue: .global(), execute: {
                print("Done")
            })
        }
    }
    
    
    /// Sets up home page title and nav bar items
    fileprivate func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = "Explore Nearby Spaces"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
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

    fileprivate func anchorCollectionView(){
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .lightGray
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        
        return collectionView
    }()
}
