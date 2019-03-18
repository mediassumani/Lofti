//
//  OnboardingViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 1/2/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class OnboardingCollectionViewController: UICollectionViewController{
    
    // - MARK: CLASS PROPERTIES
    
    // creates and styles the button to go backward
    let skipButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleSkipButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // creates and styles the button to go foward
    let nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleNextSwipe(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // creates and lays out the page controller
    lazy var pageControll: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPage = 0
        pageController.numberOfPages = Constant.pages.count
        pageController.currentPageIndicatorTintColor = .gloomyBlue
        pageController.pageIndicatorTintColor = .gray
        return pageController
    }()
    
    // - MARK: VIEW CONTROLLER LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled =  true
        collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView!.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: Constant.onboardingViewCellIdentifier)
        setUpButtonControls()
    }
    
    
    // - MARK: CLASS METHODS
    
    /// Swipes to the next page on the onboarding page
    @objc private func handleNextSwipe(_ sender: UIButton){
        
        let nextIndex = min(pageControll.currentPage + 1, Constant.pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControll.currentPage = nextIndex
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        sender.pulsate()
    }
    
    /// Skips to the user preferences page
    @objc private func handleSkipButton(_ sender: UIButton){
        
        sender.pulsate()
        AppDelegate.shared.showUserPreferencesPage()
    }
    
    /// Configures and layout the skip, next button and the UIPager element
    private func setUpButtonControls(){
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [skipButton, pageControll, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.axis = .horizontal
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
}
