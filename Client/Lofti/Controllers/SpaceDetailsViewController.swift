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
    var isOpenAndWifiStackView = CustomStackView()
    var thumbnailStackView = CustomStackView()
    var spaceNameLabel = CustomLabel()
    var isOpenLabel = UILabel()
    var phoneNumberLabel = CustomLabel()
    var getDirectionsButton = CustomButton()
    var wifiImage = UIImageView(image: UIImage(named: "wifi"))
    var spaceImagesOne = UIImageView(image: UIImage(named: "wework_one"))
    var spaceImagesTwo = UIImageView(image: UIImage(named: "wework_two"))
    var completionHandler: ((String) -> String)?
    var space: Space?
    let homepage = HomePageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setUpSpaceNameLabel()
        setUpIsOpenLabel()
        setUpThuumbnails()
        setUpPhoneNumberLabel()
        setUpGetDirectionsButton()
        mainStakViewAutoLayout()
    }
    

    
    //USER INTERFACE
    
    fileprivate func setUpSpaceNameLabel(){
        
        spaceNameLabel = CustomLabel(fontSize: 22,
                                     text: space?.name ?? "Unknown",
                                     textColor: .black,
                                     textAlignment: .center,
                                     fontName: "HelveticaNeue-Bold")
        
    }
    
    fileprivate func setUpIsOpenLabel(){

        isOpenAndWifiStackView = CustomStackView(subviews: [isOpenLabel, wifiImage],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        
        if space?.hours?.first?.is_open_now == true{
            
            isOpenLabel.text = "Open"
            isOpenLabel.textColor = .blue
            isOpenLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        }else{
            
            isOpenLabel.text = "Closed"
            isOpenLabel.textColor = .red
            isOpenLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        }
        
        NSLayoutConstraint.activate([isOpenLabel.heightAnchor.constraint(equalTo: isOpenAndWifiStackView.heightAnchor, multiplier: 0.4),
                                     isOpenLabel.widthAnchor.constraint(equalTo: isOpenAndWifiStackView.widthAnchor, multiplier: 0.6),
                                     wifiImage.heightAnchor.constraint(equalTo: isOpenAndWifiStackView.heightAnchor, multiplier: 0.6),
                                     wifiImage.widthAnchor.constraint(equalTo: isOpenAndWifiStackView.widthAnchor, multiplier: 0.3)])
        
    }
    
    fileprivate func setUpPhoneNumberLabel(){
        
        phoneNumberLabel = CustomLabel(fontSize: 19,
                                       text: space?.phone ?? "No phone number",
                                       textColor: .black,
                                       textAlignment: .center,
                                       fontName: "HelveticaNeue-Bold")
    }
    
    fileprivate func setUpThuumbnails(){
        
        thumbnailStackView = CustomStackView(subviews: [spaceImagesOne, spaceImagesTwo],
                                             alignment: .center,
                                             axis: .vertical,
                                             distribution: .fillEqually)
        
        NSLayoutConstraint.activate([spaceImagesOne.heightAnchor.constraint(equalTo: thumbnailStackView.heightAnchor, multiplier: 0.47),
                                     spaceImagesOne.widthAnchor.constraint(equalTo: thumbnailStackView.widthAnchor, multiplier: 0.9),
                                     spaceImagesTwo.heightAnchor.constraint(equalTo: thumbnailStackView.heightAnchor, multiplier: 0.47),
                                     spaceImagesTwo.widthAnchor.constraint(equalTo: thumbnailStackView.widthAnchor, multiplier: 0.9)])
        
    }
    
    fileprivate func setUpGetDirectionsButton(){
        
        getDirectionsButton = CustomButton(title: "Get Directions",
                                           fontSize: 19,
                                           titleColor: .white,
                                           target: self,
                                           action: #selector(directionsButtonTapped),
                                           event: .touchUpInside)
        
        getDirectionsButton.newLayerColor = .black
        getDirectionsButton.layer.cornerRadius = 15
        getDirectionsButton.layer.shadowRadius = 1
        getDirectionsButton.layer.masksToBounds = true
        getDirectionsButton.clipsToBounds = true
    }
    
    
    fileprivate func mainStakViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [spaceNameLabel,isOpenAndWifiStackView,phoneNumberLabel,thumbnailStackView,getDirectionsButton],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
                                     mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95),
                                     spaceNameLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     isOpenAndWifiStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
                                     isOpenAndWifiStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3),
                                     phoneNumberLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.38),
                                     phoneNumberLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
                                     thumbnailStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.6),
                                     thumbnailStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.5),
                                     getDirectionsButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5),
                                     getDirectionsButton.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.05)])
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
    
    fileprivate func setUpLabels(){

        spaceNameLabel.text = space?.name ?? "Unknown"
//        spaceLocation.text = space?.location.address1 ?? "Unknown"
//        phoneNumberTextView.text = space?.phone ?? "Unknkown"
    }
    
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

