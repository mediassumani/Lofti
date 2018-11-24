//
//  ViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageViewController: UITableViewController {

    var spaces: Result?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feeds"
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Constants.homePageCellID)
        makeApiRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    fileprivate func makeApiRequest(){
        SpaceServices.index { (spaces) in
            if let spaces = spaces{
                self.spaces = spaces
            }
        }
    }
}

extension HomePageViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
