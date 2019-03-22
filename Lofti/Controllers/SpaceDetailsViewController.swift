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
    private var actionButtonsStackView = CustomStackView()
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
    var weather: Weather?
    let homepage = HomePageViewController()
    var mapView = MKMapView.init()
    var coordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    // - MARK - VIEW CONTROLLER LIFECYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        configureAllButtons()
        configureWeatherUIElements()
        configureActionButtonsSatckView()
        
        fetchWeather()
        LocationServices.shared.centerLocationOnMap(coordinates: coordinates,
                                                    annotationTitle: space!.name,
                                                    map: mapView)
    }
    

    // - MARK: CLASS METHODS
    

    /// Styles and sets up all UILabel elements in this controller
    private func configureWeatherUIElements(){
        
        spaceNameLabel = CustomLabel(fontSize: 23,
                                     text: space?.name ?? "Unknown",
                                     textColor: .black,
                                     textAlignment: .center,
                                     fontName: "HelveticaNeue-Bold")
        
        
        guard let currentTemperature = weather?.temperature, let currentWeatherSummary = weather?.summary else { return }
        
        switch currentWeatherSummary {
        case "Sunny":
            currentWeatherImageView.image = UIImage(named: "sunny")
        case "Rainny":
            currentWeatherImageView.image = UIImage(named: "rainy")
        case "Drizzle":
            currentWeatherImageView.image = UIImage(named: "drizzle")
        case "Snowy":
            currentWeatherImageView.image = UIImage(named: "snowy")
        case "Clear":
            currentWeatherImageView.image = UIImage(named: "clear")
        case "Cloudy":
            currentWeatherImageView.image = UIImage(named: "cloudy")
        default:
            currentWeatherImageView.image = UIImage(named: "clear")
        }
        
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
        
        getDirectionsButton = CustomButton(title: "GET DIRECTIONS",
                                           fontSize: 13,
                                           titleColor: .white,
                                           target: self,
                                           action: #selector(directionsButtonTapped(_:)),
                                           event: .touchUpInside,
                                           titleFontName: "PingFangTC-Medium")
        getDirectionsButton.backgroundColor = .black
        
        getDirectionsButton.layer.cornerRadius = 7
        
        contactButton = CustomButton(title: "CONTACT",
                                     fontSize: 17, titleColor: .black,
                                     target: self,
                                     action: #selector(contactButtonIsTapped(_:)),
                                     event: .touchUpInside,
                                     titleFontName: "HelveticaNeue-Light")
        
        contactButton.layer.cornerRadius = 7
        contactButton.layer.borderWidth = 0.4
        
    }
    
    private func configureActionButtonsSatckView(){
        
        actionButtonsStackView = CustomStackView(subviews: [getDirectionsButton, contactButton],
                                                 alignment: .center,
                                                 axis: .vertical,
                                                 distribution: .fillEqually)
        actionButtonsStackView.spacing = 3
        NSLayoutConstraint.activate([
            getDirectionsButton.widthAnchor.constraint(equalTo: actionButtonsStackView.widthAnchor, multiplier: 0.7),
            getDirectionsButton.heightAnchor.constraint(equalTo: actionButtonsStackView.heightAnchor, multiplier: 0.45),
            contactButton.widthAnchor.constraint(equalTo: actionButtonsStackView.widthAnchor, multiplier: 0.7),
            contactButton.heightAnchor.constraint(equalTo: actionButtonsStackView.heightAnchor, multiplier: 0.45),
        ])
    }
    
    private func mainStakViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [weatherStackView, spaceNameLabel, mapView, actionButtonsStackView],
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
                                     mapView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 1),
                                     mapView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.6),
                                     actionButtonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.95),
                                     actionButtonsStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.16)
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
                
                self.weather = weather
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

