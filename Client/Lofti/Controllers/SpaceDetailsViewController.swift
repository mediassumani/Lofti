//
//  SpaceDetailsViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/7/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class SpaceDetailsViewController: UIViewController{
    
    var mainStackView = CustomStackView()
    var isOpenAndWifiStackView = CustomStackView()
    var actionButtonsStackView = CustomStackView()
    var spaceNameLabel = CustomLabel()
    var isOpenLabel = UILabel()
    var currentWeatherLabel = CustomLabel()
    var getDirectionsButton = CustomButton()
    var contactButton = CustomButton()
    var wifiImage = UIImageView(image: UIImage(named: "wifi"))
    var space: Space?
    let homepage = HomePageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpSpaceNameLabel()
        setUpIsOpenLabel()
        setUpcurrentWeatherLabel()
        setUpContactButton()
        setUpGetDirectionsButton()
        setUpActionButtonsStack()
        mainStakViewAutoLayout()
    }
    

    
    //USER INTERFACE
    
    private func setUpSpaceNameLabel(){
        
        spaceNameLabel = CustomLabel(fontSize: 23,
                                     text: space?.name ?? "Unknown",
                                     textColor: .black,
                                     textAlignment: .center,
                                     fontName: "HelveticaNeue-Bold")
        
    }
    
    private func setUpIsOpenLabel(){
        
        let wifiStatusLabel = CustomLabel(fontSize: 13,
                                          text: "WIFI AVAILABLE",
                                          textColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),
                                          textAlignment: .center,
                                          fontName: "HelveticaNeue-Bold")
        
        let wifiStack = CustomStackView(subviews: [wifiImage, wifiStatusLabel],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        
        
        isOpenAndWifiStackView = CustomStackView(subviews: [isOpenLabel, wifiStack],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        
        if space?.hours?.first?.is_open_now == true{
            
            isOpenLabel.text = "Open"
            isOpenLabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            isOpenLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        }else{
            
            isOpenLabel.text = "Closed"
            isOpenLabel.textColor = .red
            isOpenLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        }
        
        NSLayoutConstraint.activate([isOpenLabel.heightAnchor.constraint(equalTo: isOpenAndWifiStackView.heightAnchor, multiplier: 0.4),
                                     isOpenLabel.widthAnchor.constraint(equalTo: isOpenAndWifiStackView.widthAnchor, multiplier: 0.5),
                                     wifiImage.widthAnchor.constraint(equalTo: wifiStack.widthAnchor, multiplier: 0.2),
                                     wifiStatusLabel.widthAnchor.constraint(equalTo: wifiStack.widthAnchor, multiplier: 0.8),
                                     wifiStack.heightAnchor.constraint(equalTo: isOpenAndWifiStackView.heightAnchor, multiplier: 0.55),
                                     wifiStack.widthAnchor.constraint(equalTo: isOpenAndWifiStackView.widthAnchor, multiplier: 0.5),
                                     wifiStack.centerXAnchor.constraint(equalTo: isOpenAndWifiStackView.centerXAnchor)])
        
    }
    
    private func setUpcurrentWeatherLabel(){
        
        guard let currentTemperature = space?.weatherDegree else { return }
        
        currentWeatherLabel = CustomLabel(fontSize: 70,
                                       text: "\(Int(currentTemperature))°F",
                                       textColor: .black,
                                       textAlignment: .center,
                                       fontName: "HelveticaNeue-Thin")
    }
    
    private func setUpActionButtonsStack(){
        
        actionButtonsStackView = CustomStackView(subviews: [contactButton, getDirectionsButton],
                                                 alignment: .center,
                                                 axis: .vertical,
                                                 distribution: .fillEqually)
    }
    
    private func setUpGetDirectionsButton(){
        
        getDirectionsButton = CustomButton(title: "Get Directions",
                                           fontSize: 18,
                                           titleColor: .black,
                                           target: self,
                                           action: #selector(directionsButtonTapped(_:)),
                                           event: .touchUpInside,
                                           titleFontName: "HelveticaNeue-Light")
        
        getDirectionsButton.layer.borderWidth = 0.4
    }
    
    private func setUpContactButton(){
        
        contactButton = CustomButton(title: "Contact",
                                     fontSize: 18, titleColor: .black,
                                     target: self,
                                     action: #selector(contactButtonIsTapped(_:)),
                                     event: .touchUpInside,
                                     titleFontName: "HelveticaNeue-Light")
        
        contactButton.layer.borderWidth = 0.4

    }
    
    
    private func mainStakViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [spaceNameLabel,isOpenAndWifiStackView,currentWeatherLabel,actionButtonsStackView],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     spaceNameLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     isOpenAndWifiStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
                                     isOpenAndWifiStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
                                     isOpenAndWifiStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
                                     currentWeatherLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.4),
                                     currentWeatherLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.6),
                                     actionButtonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
                                     actionButtonsStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2),
                                     getDirectionsButton.widthAnchor.constraint(equalTo: actionButtonsStackView.widthAnchor, multiplier: 0.8),
                                     getDirectionsButton.heightAnchor.constraint(equalTo: actionButtonsStackView.heightAnchor, multiplier: 0.5),
                                     contactButton.widthAnchor.constraint(equalTo: actionButtonsStackView.widthAnchor, multiplier: 0.8),
                                     contactButton.heightAnchor.constraint(equalTo: actionButtonsStackView.heightAnchor, multiplier: 0.5)
            ])
    }
    
    
    
    @objc private func directionsButtonTapped(_ sender: UIButton){
        
        sender.pulsate()
        guard let space = self.space else {return}
        let address = "\(space.location.address1) \(space.location.city) \(space.location.state)"
        LocationServices.addressToCoordinate(address) { (coordinates) in
            
            guard let longitude = coordinates?.longitude, let latitude = coordinates?.latitude else {return}
            
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placeMark = MKPlacemark(coordinate: coordinates)
            let regionSpan = MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)
            let mapItems = MKMapItem(placemark: placeMark)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan)]
    
            mapItems.name = space.name
            mapItems.openInMaps(launchOptions: options)
        }
    }
    
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

