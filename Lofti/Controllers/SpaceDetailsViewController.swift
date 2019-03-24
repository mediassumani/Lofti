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
        setUpNavigationBarItems()
        fetchWeather()
        LocationServices.shared.centerLocationOnMap(coordinates: coordinates,
                                                    annotationTitle: space!.name,
                                                    map: mapView, isOpen: (space?.hours?.first?.is_open_now)!)
    }
    

    // - MARK: CLASS METHODS
    

    /// Styles and sets up all UILabel elements in this controller
    private func configureWeatherUIElements(){
        
        guard let currentTemperature = weather?.temperature, let currentWeatherSummary = weather?.summary else { return }
        
        switch currentWeatherSummary {
        case "Sunny":
            currentWeatherImageView.image = UIImage(named: "sun")
        case "Rainny":
            currentWeatherImageView.image = UIImage(named: "rain")
        case "Drizzle":
            currentWeatherImageView.image = UIImage(named: "rain")
        case "Snowy":
            currentWeatherImageView.image = UIImage(named: "snowy")
        case "Clear":
            currentWeatherImageView.image = UIImage(named: "clear")
        case "Cloudy":
            currentWeatherImageView.image = UIImage(named: "cloudy")
        default:
            currentWeatherImageView.image = UIImage(named: "clear")
        }
        
        currentWeatherLabel = CustomLabel(fontSize: 25,
                                          text: "\(Int(currentTemperature))°F",
            textColor: .darkBlue,
            textAlignment: .center,
            fontName: "HelveticaNeue-Light")
        
        
        
        weatherStackView = CustomStackView(subviews: [currentWeatherImageView, currentWeatherLabel],
                                           alignment: .center,
                                           axis: .horizontal,
                                           distribution: .fillEqually)
        
        NSLayoutConstraint.activate([currentWeatherImageView.widthAnchor.constraint(equalTo: weatherStackView.widthAnchor, multiplier: 0.35),
                                     currentWeatherImageView.heightAnchor.constraint(equalTo: weatherStackView.heightAnchor, multiplier: 0.95),
                                     currentWeatherLabel.widthAnchor.constraint(equalTo: weatherStackView.widthAnchor, multiplier: 0.5),
                                     currentWeatherLabel.heightAnchor.constraint(equalTo: weatherStackView.heightAnchor, multiplier: 0.5)
                                     ])
    }
    
    private func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = space?.name
        titleLabel.textColor = .darkBlue
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.alpha = 1
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
        getDirectionsButton.backgroundColor = .darkBlue
        getDirectionsButton.layer.cornerRadius = 25
        
        contactButton = CustomButton(title: "CONTACT",
                                     fontSize: 17, titleColor: .white,
                                     target: self,
                                     action: #selector(contactButtonIsTapped(_:)),
                                     event: .touchUpInside,
                                     titleFontName: "PingFangTC-Medium")
        contactButton.backgroundColor = .darkBlue
        contactButton.layer.cornerRadius = 25
        
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
        
        mainStackView = CustomStackView(subviews: [mapView],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        view.addSubview(mainStackView)
        mapView.addSubview(weatherStackView)
        mapView.addSubview(actionButtonsStackView)
        NSLayoutConstraint.activate([
                                     mainStackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     mainStackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     weatherStackView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.1),
                                     weatherStackView.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.3),
                                     weatherStackView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                                     mapView.safeAreaLayoutGuide.widthAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
                                     mapView.safeAreaLayoutGuide.heightAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
                                     actionButtonsStackView.safeAreaLayoutGuide.widthAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
                                     actionButtonsStackView.safeAreaLayoutGuide.heightAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.17),
                                     actionButtonsStackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
                let alertController = UIAlertController(title: "Contact", message: "Are you sure you want to call \n\(number)?", preferredStyle: .alert)
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

