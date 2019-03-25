//
//  OnboardingViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 3/21/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    private let onboardingView = PaperOnboarding()
    private let pagerIcon = UIImage(named: "white_circle.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
        mainAutoLayout()
    }
    
    let getStartedButton: UIButton = {

        let button = UIButton(type: .system)
        button.setTitle("GET STARTED", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleGetStartedButton(_:)), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    /// Skips to show the user a page to select their preferences
    @objc private func handleGetStartedButton(_ sender: UIButton){

        sender.pulsate()
        AppDelegate.shared.showUserPreferencesPage()
    }
    
    /// Lays out the onboarding view and `GET STARTED` button
    private func mainAutoLayout(){
        
        view.addSubview(onboardingView)
        view.addSubview(getStartedButton)
        onboardingView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        NSLayoutConstraint.activate([
            getStartedButton.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.width/3))
        ])
    }
    
    /// The number of pages for the onboarding
    func onboardingItemsCount() -> Int {
        return 5
    }
    
    /// Sets up the pages that will be displayed during onboarding
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "Logo_onboarding")!,
                                               title: "Welcome to Lofti",
                                               description: "Lofti's mission is to connect people and nearby working spaces based on their preferences.",
                                               pageIcon: pagerIcon!,
                                               color: .black,
                                               titleColor: .white,
                                               descriptionColor: .white,
                                               titleFont: titleFont,
                                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "distance")!,
                               title: "Distance",
                               description: "Working/study spaces are presented to you in order of closest to farthest. Click on a specific space to get a map view of the area.",
                               pageIcon: pagerIcon!,
                               color: .cyanGreen,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "telephone")!,
                               title: "Contact",
                               description: "Want to learn more about a specific space? You can call their customer service through the app.",
                               pageIcon: pagerIcon!,
                               color: .white,
                               titleColor: .black,
                               descriptionColor: .black,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "weather_onboarding")!,
                               title: "Weather",
                               description: "Easily see the current weather at the space's location before you leave your house.",
                               pageIcon: pagerIcon!,
                               color: .lightBlue,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "preferences")!,
                               title: "Preferences",
                               description: "Where are you productive? Libraries, coffeeshops, or shared offices (e.g. WeWork)? Choose your preferences on the next page.",
                               pageIcon: pagerIcon!,
                               color: .lightPink,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            ][index] as OnboardingItemInfo
    }
    
    /// Makes sure the `GET STARTED` button is hidden until the last page
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if index == 3 {

            if self.getStartedButton.alpha == 3 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButton.alpha = 0
                })
            }
            
        }
    }
    
    /// Animates the `GET STARTED` button to appear when on last page
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 4 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
}

