//
//  SpaceDetailsViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/7/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//
import CoreLocation
import Foundation
import MapKit
import UIKit

class SpaceDetailsViewController: UIViewController{
    
    // - MARK: CLASS PROPERTIES
    
    private var mainStackView = CustomStackView()
    private var amenitiesStackView = CustomStackView()
    private var actionButtonsStackView = CustomStackView()
    private var openAndBathroomStackView = CustomStackView()
    private var plugAndWifiStackView = CustomStackView()
    private var weatherStackView = CustomStackView()
    
    private var spaceNameLabel = CustomLabel()
    private var amenitiesLabel = CustomLabel()
    private var currentWeatherLabel = CustomLabel()
    
    private var getDirectionsButton = CustomButton()
    private var contactButton = CustomButton()
    
    private var wifiAvailabilityImageView = UIImageView(image: UIImage(named: "wifi"))
    private var spaceOpenStatusImageView = UIImageView()
    private var plugImageView = UIImageView()
    private var bathroomImageView = UIImageView()
    private var currentWeatherImageView = UIImageView()
    
    var space: Space?
    let homepage = HomePageViewController()
    var mapView = MKMapView.init()
    var coordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    // - MARK - VIEW CONTROLLER LIFECYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //configureAllLabels()
        configureAllButtons()
        configureAllImages()
        configureWeatherUIElements()
        configureOpenAndBathroomElements()
        configurePlugAndWifiUIElements()
        //configureActionButtons()
        configureAmenitiesUIElements()
        setUpMapView()
        
        fetchWeather()
        LocationServices.shared.centerLocationOnMap(coordinates: coordinates,
                                                    annotationTitle: space!.name,
                                                    map: mapView)
    }
    

    // - MARK: CLASS METHODS
    
    private func configureOpenAndBathroomElements(){
        
        openAndBathroomStackView = CustomStackView(subviews: [spaceOpenStatusImageView, bathroomImageView],
                                                   alignment: .center,
                                                   axis: .horizontal,
                                                   distribution: .fillEqually)
        
        NSLayoutConstraint.activate([
            
            spaceOpenStatusImageView.widthAnchor.constraint(equalTo: openAndBathroomStackView.widthAnchor, multiplier: 0.5),
            spaceOpenStatusImageView.heightAnchor.constraint(equalTo: openAndBathroomStackView.heightAnchor, multiplier: 0.6),
            bathroomImageView.widthAnchor.constraint(equalTo: openAndBathroomStackView.widthAnchor, multiplier: 0.5),
            bathroomImageView.heightAnchor.constraint(equalTo: openAndBathroomStackView.heightAnchor, multiplier: 0.6)
            
            ])
    }
    
    private func configurePlugAndWifiUIElements(){
        
        plugAndWifiStackView = CustomStackView(subviews: [plugImageView, wifiAvailabilityImageView],
                                               alignment: .center,
                                               axis: .horizontal,
                                               distribution: .fill)
        
        NSLayoutConstraint.activate([
            plugImageView.widthAnchor.constraint(equalTo: plugAndWifiStackView.widthAnchor, multiplier: 0.5),
             plugImageView.heightAnchor.constraint(equalTo: plugAndWifiStackView.heightAnchor, multiplier: 0.6),
             wifiAvailabilityImageView.widthAnchor.constraint(equalTo: plugAndWifiStackView.widthAnchor, multiplier: 0.5),
             wifiAvailabilityImageView.heightAnchor.constraint(equalTo: plugAndWifiStackView.heightAnchor, multiplier: 0.7)
            ])
    }
    private func configureAmenitiesUIElements(){
        
        amenitiesLabel = CustomLabel(fontSize: 15,
                                     text: "Amenities & Accomodation",
                                     textColor: .black,
                                     textAlignment: .center,
                                     fontName: "HelveticaNeue-Bold")
        
        amenitiesStackView = CustomStackView(subviews: [openAndBathroomStackView, plugAndWifiStackView],
                                             alignment: .center,
                                             axis: .vertical,
                                             distribution: .fillEqually)
        //amenitiesStackView.spacing = 1
        
        NSLayoutConstraint.activate([
                                     openAndBathroomStackView.widthAnchor.constraint(equalTo: amenitiesStackView.widthAnchor, multiplier: 0.6),
                                     openAndBathroomStackView.heightAnchor.constraint(equalTo: amenitiesStackView.heightAnchor, multiplier: 0.4),
                                     plugAndWifiStackView.widthAnchor.constraint(equalTo: amenitiesStackView.widthAnchor, multiplier: 0.4),
                                     plugAndWifiStackView.heightAnchor.constraint(equalTo: amenitiesStackView.heightAnchor, multiplier: 0.3)
                                     ])
        
        
    }
    /// Styles and sets up all UILabel elements in this controller
    private func configureWeatherUIElements(){
        
        spaceNameLabel = CustomLabel(fontSize: 23,
                                     text: space?.name ?? "Unknown",
                                     textColor: .black,
                                     textAlignment: .center,
                                     fontName: "HelveticaNeue-Bold")
        
        
        guard let currentTemperature = space?.weatherDegree else { return }
        
        currentWeatherLabel = CustomLabel(fontSize: 20,
                                          text: "\(Int(currentTemperature))°F",
            textColor: .black,
            textAlignment: .center,
            fontName: "HelveticaNeue-Thin")
        
        
        
        weatherStackView = CustomStackView(subviews: [currentWeatherImageView, currentWeatherLabel],
                                           alignment: .center,
                                           axis: .horizontal,
                                           distribution: .fillEqually)
        
        NSLayoutConstraint.activate([currentWeatherImageView.widthAnchor.constraint(equalTo: weatherStackView.widthAnchor, multiplier: 0.35),
                                     currentWeatherImageView.heightAnchor.constraint(equalTo: weatherStackView.heightAnchor, multiplier: 0.8),
                                     currentWeatherLabel.widthAnchor.constraint(equalTo: weatherStackView.widthAnchor, multiplier: 0.5),
                                     currentWeatherLabel.heightAnchor.constraint(equalTo: weatherStackView.heightAnchor, multiplier: 0.4)])
    }
    
    /// Styles and sets up all UIButton elements in this controller
    private func configureAllButtons(){
        
        getDirectionsButton = CustomButton(title: "Get Directions",
                                           fontSize: 18,
                                           titleColor: .black,
                                           target: self,
                                           action: #selector(directionsButtonTapped(_:)),
                                           event: .touchUpInside,
                                           titleFontName: "HelveticaNeue-Light")
        
        getDirectionsButton.layer.borderWidth = 0.4
        
        contactButton = CustomButton(title: "Contact",
                                     fontSize: 18, titleColor: .black,
                                     target: self,
                                     action: #selector(contactButtonIsTapped(_:)),
                                     event: .touchUpInside,
                                     titleFontName: "HelveticaNeue-Light")
        
        contactButton.layer.borderWidth = 0.4
        
    }
    
    /// Styles and sets up all UIImageView elements in this controller
    private func configureAllImages(){
        
        plugImageView.image = UIImage(named: "plug")
        bathroomImageView.image = UIImage(named: "toilet")
        wifiAvailabilityImageView.image = UIImage(named: "wifi")
        currentWeatherImageView.image = UIImage(named: "snowy")
        
        
        // Configuring the label that displays whether the space is open or closed
        if space?.hours?.first?.is_open_now == true{
            spaceOpenStatusImageView.image = UIImage(named: "open")
            
        }else{
            spaceOpenStatusImageView.image = UIImage(named: "close")
            
        }
    }
    
//    private func configureActionButtons(){
//
//        actionButtonsStackView = CustomStackView(subviews: [getDirectionsButton],
//                                                         alignment: .center,
//                                                         axis: .vertical,
//                                                         distribution: .fillEqually)
//
//        NSLayoutConstraint.activate([
//
//            getDirectionsButton.widthAnchor.constraint(equalTo: actionButtonsStackView.widthAnchor, multiplier: 1),
//            getDirectionsButton.heightAnchor.constraint(equalTo: actionButtonsStackView.heightAnchor, multiplier: 1),
////            contactButton.widthAnchor.constraint(equalTo: actionButtonsStackView.widthAnchor, multiplier: 0.2),
////
////            contactButton.heightAnchor.constraint(equalTo: actionButtonsStackView.heightAnchor, multiplier: 0.3)
//        ])
//    }
    
    func setUpMapView(){
       
       mapView.layer.cornerRadius = view.frame.width/2.7
    }

    
    private func mainStakViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [weatherStackView, spaceNameLabel, mapView, amenitiesStackView, getDirectionsButton],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     weatherStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.07),
                                     weatherStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3),
                                     spaceNameLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
                                     mapView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
                                     mapView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.4),
                                     amenitiesStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5),
                                     amenitiesStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.3),
                                     getDirectionsButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5),
                                     getDirectionsButton.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.06),
            ])
    }
    
    
    /// Opens the Map App with the itenerary to the the selected space
    @objc private func directionsButtonTapped(_ sender: UIButton){
        
        sender.pulsate()
        guard let space = self.space else {return}
        
        // Get the coordinates of the space's location
        let address = "\(space.location.address1) \(space.location.city) \(space.location.state)"
        LocationServices.shared.addressToCoordinate(address) { (coordinates) in
            
            guard let longitude = coordinates?.longitude, let latitude = coordinates?.latitude else {return}
            
            // Make proper configuration to open the iOS Map Application
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placeMark = MKPlacemark(coordinate: coordinates)
            let regionSpan = MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)
            let mapItems = MKMapItem(placemark: placeMark)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan)]
    
            mapItems.name = space.name
            mapItems.openInMaps(launchOptions: options)
        }
    }
    
    private func fetchWeather(){

        WeatherServices.shared.getForecastAt(longitude: coordinates.longitude, latitude: coordinates.latitude) { (result) in
            switch result{
            case let .success(weather):
                guard let tempAtLocation = weather.temperature else { return }
                
                self.space?.weatherDegree = tempAtLocation
                self.configureWeatherUIElements()
                self.mainStakViewAutoLayout()
                
            case let .failure(error):
                print(error)
            }
        }
    }
    /// Makes a phone call to the space's custome service
    @objc private func contactButtonIsTapped(_ sender: UIButton){
        
        sender.pulsate()
        guard let number = space?.phone else { return }
       
        // Code from Pratik Patel on Stack Overflow
        if let phoneCallURL:URL = URL(string: "tel:\(number)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: "Lofti", message: "Are you sure you want to call \n\(number)?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                })
                let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
                    
                })
                
                alertController.addAction(yesPressed)
                alertController.addAction(noPressed)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

