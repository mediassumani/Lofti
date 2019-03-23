//
//  UserPreferencesVC+Extension.swift
//  Lofti
//
//  Created by Medi Assumani on 1/2/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension UserPreferencesViewController: UICollectionViewDelegateFlowLayout {
    
    
    // - MARK: UICollectionView DATASOURCE METHODS
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Constant.PAUSIBLE_PREFERENCES.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPreferencesViewCell.cellIdentifier, for: indexPath) as! UserPreferencesViewCell
        
        cell.configureCell(preference: Constant.PAUSIBLE_PREFERENCES[indexPath.row], backgroundImage: Constant.PREFERENCE_CELL_IMAGES[indexPath.row])

        return cell
    }
    
    /// Caches the user's prefernce choice on userdefault if selected and shows proper alert
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath)
        if selectedCell?.isSelected == true{
            
            selectedCell?.alpha = 0.5
            Constant.createStatusAlert(title: "Saved", message: "The selected preference has been saved.", choice: .selected)
            let userChoice = Constant.PAUSIBLE_PREFERENCES[indexPath.row].replacingOccurrences(of: " ", with: "")
            
            if !(preferences.contains(userChoice)){
                preferences.append(userChoice)
            }
        }
    }
    
    /// Uncaches the user's prefernce choice from userdefault if deselected and shows proper alert
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.alpha = 1
        Constant.createStatusAlert(title: "Unsaved", message: "The deselected preference has been unsaved.", choice: .deselected)
    
        let userChoice = Constant.PAUSIBLE_PREFERENCES[indexPath.row].replacingOccurrences(of: " ", with: "")
        if (preferences.contains(userChoice)){
            preferences.removeAll(where: { $0 == userChoice })
        }
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

