//
//  SpaceDetailsViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/7/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


class SpaceDetailsViewController: UIViewController, SpaceDelegate{
    
    var mainStackView = UIStackView()
    var completionHandler: ((String) -> String)?
    var space: Space?
    let homepage = HomePageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .white
        setUpLabels()
        setUpMainStackView()
        //homepage.spaceDelegate = self
        
    }

    
    //USER INTERFACE
    
    
    // The textview to show the name of the space
    private let spaceNameTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // The textview to show the renting price
    private let phoneNumberTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    // The textview to show the time availability of the place
    private let spaceLocation: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func passSpaceData(space: Space?) {
        //self.space = space
        print(self.space?.id)
    }
    
    
    
    
    fileprivate func setUpLabels(){
        
        spaceNameTextView.text = space?.name ?? "Unknown"
        spaceLocation.text = space?.location.address1 ?? "Unknown"
        phoneNumberTextView.text = space?.phone ?? "Unknkown"
    }
    
    fileprivate func setUpMainStackView(){
        
        mainStackView = UIStackView(arrangedSubviews: [spaceNameTextView, phoneNumberTextView, spaceLocation])
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
}

//extension SpaceDetailsViewController: SpaceDelegate{
//
//    func passSpaceData(space: Space?) {
//        //self.space = space
//        print(self.space?.id)
//    }
//}
