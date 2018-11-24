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
    var categories = ["adultedu", "collegeuniv","highschools", "privateschools", "libraries"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feeds"
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Constants.homePageCellID)
        makeApiRequest(location: "San Francisco")
    }

    func makeApiRequest(location: String){
        SpaceServices.index { (space) in
            guard let spaceName = space?.name else {return}
            //print(spaceName)
        }
    }
}


extension HomePageViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaces.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: Constants.homePageCellID, for: indexPath) as! HomePageTableViewCell
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ViewSpaceViewController() as ViewSpaceViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
