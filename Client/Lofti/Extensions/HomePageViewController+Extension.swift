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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC = SpaceDetailsViewController()
        let selectedSpace = spaces[indexPath.row]
        let address = "\(selectedSpace.location.address1) \(selectedSpace.location.city) \(selectedSpace.location.state)"
        
        
        
        SpaceServices.show(id: selectedSpace.id) { (space) in
            
            selectedSpace.hours = space.hours
            destinationVC.space = selectedSpace
        }
        
        
        LocationServices.addressToCoordinate(address) { (coordinates) in
            
            guard let longitude = coordinates?.longitude, let latitude = coordinates?.latitude else {return}
            let weatherServices = WeatherServices.init(latitude, longitude)
            
            weatherServices.getForecast({ (weather) in
                guard let spaceLocationTemperature = weather.temperature else { return }
                destinationVC.space?.weatherDegree = spaceLocationTemperature
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
            })
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as! HomePageCollectionViewCell
        
        let currentSpace = spaces[indexPath.row]
        cell.configure(currentSpace)
        
        return cell
    }
}

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
