//
//  UserPreferencesViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class UserPreferencesViewController: UICollectionViewController{

    // - MARK: CLASS PROPERTIES
    private let mainStackView = CustomStackView()
    var saveButton = CustomButton()
    var preferences = [String](){
        didSet{
            UIView.animate(withDuration: 1.0) {
                self.saveButton.alpha = 1
            }
        }
    }
    
    // - MARK: VIEW CONTROLLER LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBarItems()
        configureCollectionView()
        styleSaveButton()
        mainAutoLayout()
    }
    
    
    // - MARK: CLASS METHODS
    
    private func configureCollectionView(){
        
        collectionView.backgroundColor = .lightGray
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.register(UserPreferencesViewCell.self, forCellWithReuseIdentifier: UserPreferencesViewCell.cellIdentifier)
    }
    
    
    /// Sets up home page title and nav bar items
    private func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = "Categories"
        titleLabel.textColor = .darkBlue
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0
    }
    
    
    @objc private func saveButtonIsTapped(_ sender: UIButton){
        
        let destinationVC = HomePageViewController()
        var userPreferences = ""
        sender.pulsate()
        
        preferences.forEach { (preference) in
            userPreferences += "\((preference.lowercased()).replacingOccurrences(of: " ", with: ","))"
        }

        UserDefaults.standard.set(userPreferences, forKey: "user_space_preferences")
        UserDefaults.standard.set(true, forKey: "current_user")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func styleSaveButton(){
        
        
        saveButton = CustomButton(title: "DONE",
                                  fontSize: 13,
                                  titleColor: .white,
                                  target: self,
                                  action: #selector(saveButtonIsTapped(_:)),
                                  event: .touchUpInside,
                                  titleFontName: "PingFangTC-Medium")
        
        saveButton.alpha = 0
        saveButton.backgroundColor = .darkBlue
        saveButton.layer.cornerRadius = 25
        saveButton.clipsToBounds = true
        saveButton.layer.masksToBounds = true
        saveButton.layer.shadowRadius = 1
        saveButton.shake()
    }
    
    
    private func mainAutoLayout(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [saveButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.axis = .horizontal
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomControlsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
