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
    
    var mainStackView = UIStackView()
    //var completionHandler: ((String) -> String)?
    //var space: Space?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        setUpMainStackView()
        getSpaceData()
    }
    
    func getSpaceData(){
//        let senderVC = HomePageViewController()
//        senderVC.spaceDelegate = self as? SpaceData
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
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    // The textview to show the time availability of the place
    private let spaceLocation: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    
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

//extension SpaceDetailsViewController: SpaceData{
//
//    func passSpaceData(space: Space?) {
//        self.space = space
//    }

