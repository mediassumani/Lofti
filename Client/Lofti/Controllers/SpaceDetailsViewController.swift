//
//  SpaceDetailsViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/7/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


class SpaceDetailsViewController: UIViewController{
    
    var mainStackView = CustomStackView()
    var spaceNameLabel = CustomLabel()
    var isOpenLabel = CustomLabel()
    var phoneNumberLabel = CustomLabel()
    var getDirectionsButton = CustomButton()
    var wifiImage = UIImage()
    var completionHandler: ((String) -> String)?
    var space: Space?
    let homepage = HomePageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .white
        //setUpLabels()
        //setUpMainStackView()
        //homepage.spaceDelegate = self
        
    }

    
    //USER INTERFACE
    
    fileprivate func setUpIsOpenLabel(){
        
        var text: String = ""
        var color: UIColor = .white
        
        if space?.hours?.first?.is_open_now == true{
            text = "Open"
            color = .blue
        }else{
            text = "closed"
            color = .red
        }
        
        
        isOpenLabel = CustomLabel(fontSize: 15, text: text, textColor: color, textAlignment: .center, fontName: "HelveticaNeue-Bold")
    }
    
    fileprivate func setUpGetDirectionsButton(){
        
        getDirectionsButton = CustomButton(title: "Directions",
                                           fontSize: 12,
                                           titleColor: .white,
                                           target: self,
                                           action: #selector(directionsButtonTapped),
                                           event: .touchUpInside)
        
        getDirectionsButton.layer.cornerRadius = 15
        getDirectionsButton.layer.shadowRadius = 1
        getDirectionsButton.layer.masksToBounds = true
        getDirectionsButton.clipsToBounds = true
    }
    
    
    
    @objc fileprivate func directionsButtonTapped(){
        
//        let regionSpan = MKCoordinateSpan(latitudeDelta: location.latitude, longitudeDelta: location.longitude)
//
//        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan)]
//
//        // Aesthetic add in
//        let placeMark = MKPlacemark(coordinate: location) // pin
//        let mapItems = MKMapItem(placemark: placeMark)  // the bottom two is for the name showing up
//        mapItems.name = DataObject.dataArray[row].name  //
//
//        mapItems.openInMaps(launchOptions: options)     // function that open maps
//        print(location)
        
    }
    
//    fileprivate func setUpLabels(){
//
//        spaceNameTextView.text = space?.name ?? "Unknown"
//        spaceLocation.text = space?.location.address1 ?? "Unknown"
//        phoneNumberTextView.text = space?.phone ?? "Unknkown"
//    }
    
//    fileprivate func setUpMainStackView(){
//
//        mainStackView = CustomStackView(subviews: [spaceNameTextView, phoneNumberTextView, spaceLocation], alignment: .center, axis: .vertical, distribution: .fillEqually)
//        view.addSubview(mainStackView)
//        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
//    }
    
}

