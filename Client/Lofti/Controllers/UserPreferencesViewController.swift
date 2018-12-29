//
//  UserPreferencesViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 12/27/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class UserPreferencesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    private let mainStackView = CustomStackView()
    private var saveButton = CustomButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        styleSaveButton()
        mainAutoLayout()
        setUpNavigationBarItems()
        
        
    }
    
    private func configureCollectionView(){
        
        collectionView.backgroundColor = .lightGray
        collectionView.register(UserPreferencesViewCell.self, forCellWithReuseIdentifier: Constant.userPreferencesCellID)
    }
    
    
    /// Sets up home page title and nav bar items
    private func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = "Select your preferences"
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
    
    
    @objc private func saveButtonIsTapped(_ sender: UIButton){
        print("save button is pressed")
    }
    
    private func styleSaveButton(){
        
        saveButton = CustomButton(title: "Done", fontSize: 20, titleColor: .black, target: self, action: #selector(saveButtonIsTapped(_:)), event: .touchUpInside)
        
        saveButton.backgroundColor = .black
        saveButton.layer.cornerRadius = 15
        saveButton.clipsToBounds = true
        saveButton.layer.masksToBounds = true
        saveButton.layer.shadowRadius = 1
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
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.userPreferencesCellID, for: indexPath) as! UserPreferencesViewCell
        
//        cell.preferenceNameLabel.text =
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth/2.2, height: screenWidth/3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
