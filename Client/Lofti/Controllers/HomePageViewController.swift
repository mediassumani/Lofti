//
//  ViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageViewController: UITableViewController {

    var spaces: [Space] = [Space]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Feeds"
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Constants.homePageCellID)
        createDummyData()
    }

    
    fileprivate func createDummyData(){
        spaces.append(Space("Ozone Studio", "Nice Cozy space to study", "12:30PM - 4:45 PM", UIImage(named: "space1")!, "246 McAllister Ave", "Medi Assumani", 3, false, 5.30))
        
        spaces.append(Space("Redwood Baklava", "Small tidy place to work", "09:00AM - 5:00PM", UIImage(named: "space2")!, "555 Post ST", "Make School", 5, true, 7.50))
        
        spaces.append(Space("Willow Waffle", "Clean space for small study group","03:00PM - 5:00PM",  UIImage(named: "space3")!, "555 Post ST", "Make School", 4, true, 9.0))
        
        spaces.append(Space("Tea Tree Torte", "Cozy small place to work", "07:00PM - 8:00PM", UIImage(named: "space4")!, "555 Post ST", "Make School", 3, true, 7.50))
        
        spaces.append(Space("Manzanita Macaroon", "Small tidy place to work", "09:00AM - 5:00PM", UIImage(named: "space5")!, "555 Post ST", "Make School", 3, true, 7.50))
    }
}


extension HomePageViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaces.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: Constants.homePageCellID, for: indexPath) as! HomePageTableViewCell
        let currentLastItem = spaces[indexPath.row]
        cell.space = currentLastItem
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
}
