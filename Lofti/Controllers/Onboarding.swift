//
//  Onboarding.swift
//  Lofti
//
//  Created by Medi Assumani on 3/21/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit
import paper_onboarding

class Onboarding: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    //private var onboardingView = OnBoardingView()
    let onboardingView = PaperOnboarding()
    let dummyImage = UIImage(named: "transparent")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
        mainAutoLayout()
    }
    
        // creates and styles the button to go foward
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
    
    
    private func mainAutoLayout(){
        
        view.addSubview(onboardingView)
        view.addSubview(getStartedButton)
        onboardingView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        NSLayoutConstraint.activate([
            getStartedButton.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.width/3))
        ])
    }
    
    func onboardingItemsCount() -> Int {
        return 5
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let backgroundColorOne = UIColor.black
        var backgroundColorTwo = UIColor.lightBlue
        var backgroundColorThree = UIColor(red: 1, green: 0.3882, blue: 0.9176, alpha: 1.0)
        var backgroundColorFour = UIColor(red: 0.0627, green: 0.8078, blue: 0.6824, alpha: 1.0)
        var backgroundColorFive = UIColor(red: 0.4235, green: 0.7569, blue: 0.1647, alpha: 1.0) /* #6cc12a */
        
        var titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        var descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "Logo_onboarding")!,
                                               title: "Welcome to Lofti",
                                               description: "Lofti's mission is to connect peoole and working spaces based on their preferences.",
                                               pageIcon: dummyImage!,
                                               color: backgroundColorOne,
                                               titleColor: .white,
                                               descriptionColor: .white,
                                               titleFont: titleFont,
                                               descriptionFont: descirptionFont),
                            
            OnboardingItemInfo(informationImage: UIImage(named: "preferences")!,
                               title: "Preferences",
                               description: "As a first time user, select your study/working environment preferences such as Libraries, coffeshops, or Shared offices(e.g: WeWork).",
                               pageIcon: dummyImage!,
                               color: backgroundColorThree,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "distance")!,
                               title: "Distance",
                               description: "Working spaces are filtered in order of closest to farthest. Click on a specific space to get a map view of the area.",
                               pageIcon: dummyImage!,
                               color: backgroundColorFour,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "contact")!,
                               title: "Contact",
                               description: "You have the option to call the customer service of a specific space to learn more about them.",
                               pageIcon: dummyImage!,
                               color: backgroundColorFive,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
            
            OnboardingItemInfo(informationImage: UIImage(named: "weather_onboarding")!,
                               title: "Weather",
                               description: "Easily see the current weather at the space's location before you leave your house.",
                               pageIcon: dummyImage!,
                               color: backgroundColorTwo,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont)
            ][index] as OnboardingItemInfo
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if index == 3 {

            if self.getStartedButton.alpha == 3 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButton.alpha = 0
                })
            }
            
        }
    }
    
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 4 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
}

