//
//  HomePageViewController+Extension.swift
//  Lofti
//
//  Created by Medi Assumani on 12/5/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spaces.count
    }
    
    // Transfers data of the selected space model to the destination view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC = SpaceDetailsViewController()
        let selectedSpace = spaces[indexPath.row]
        let address = "\(selectedSpace.location.address1) \(selectedSpace.location.city) \(selectedSpace.location.state)"
        
        SpaceServices.shared.fetchSingleSpace(id: selectedSpace.id) { (result) in
            switch result{
            case let .success(space):
                selectedSpace.hours = space.hours
                destinationVC.space = selectedSpace
                LocationServices.addressToCoordinate(address) { (coordinates) in
                    
                    guard let longitude = coordinates?.longitude, let latitude = coordinates?.latitude else {return}
                    //guard let spaceLocationTemperature = weather.temperature else { return }
                    destinationVC.coordinates = (longitude, latitude)
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                    
                    //            WeatherServices.shared.getForecastAt(with: longitude, and: latitude, completion: { (result) in
                    //
                    //                switch result{
                    //                case let .success(weather):
                    //                    guard let spaceLocationTemperature = weather.temperature else { return }
                    //                    destinationVC.space?.weatherDegree = spaceLocationTemperature
                    //                    DispatchQueue.main.async {
                    //                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    //                    }
                    //                case let .failure(error):
                    //                    print(error)
                    //                }
                    //            })
                }
                
            case let .failure(error):
                print(error)
            }
        }
        
        // Gets the weather tempeterature of the space's location
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as! HomePageCollectionViewCell
        
        let currentSpace = spaces[indexPath.row]
        cell.configure(currentSpace)
        
        return cell
    }
}

// This Extension style and configures each collection view cell
extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth/1.2, height: screenWidth/1.5)
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
        return 20
    }
    
}
