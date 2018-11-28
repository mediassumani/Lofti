//
//  ViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit

protocol SpaceDelegate: class{
    func passSpaceData(space: Space?)
}

class HomePageViewController: UIViewController{

    var spaces = [Space](){
        didSet{
            DispatchQueue.main.async {
                self.spaceListTableView.reloadData()
            }
        }
    }
    weak var spaceDelegate: SpaceDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.title = "Spaces"
        self.spaceListTableView.delegate = self as UITableViewDelegate
        self.spaceListTableView.dataSource = self as UITableViewDataSource
        
        view.addSubview(spaceListTableView)
        spaceListTableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Constants.homePageCellID)
        fetchSpaces()
        anchorTableView()
        setUpNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.spaceListTableView.reloadData()
        }
    }
    
    /// Sets up home page title and nav bar items
    fileprivate func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = "Home"
        titleLabel.textColor = .gray
        titleLabel.font = UIFont(name: "Rockwell", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0
    }

    fileprivate func fetchSpaces(){
        SpaceServices.fetchNearbySpaces { (spaces) in
            spaces.forEach({ (space) in
                self.spaces.append(space)
            })
        }
    }
    
    func anchorTableView(){
        spaceListTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    let spaceListTableView: UITableView = {
        
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = spaceListTableView.dequeueReusableCell(withIdentifier: Constants.homePageCellID, for: indexPath) as! HomePageTableViewCell
        
        let selectedSpace = spaces[indexPath.row]
        cell.spaceNameLabel.text = selectedSpace.name ?? "Unknown"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let destinationVC = SpaceDetailsViewController() as SpaceDetailsViewController
        let selectedSpace = spaces[indexPath.row]
        //destinationVC.spaceDelegate = self as? SpaceDelegate
        //spaceDelegate?.passSpaceData(space: selectedSpace)
        destinationVC.space = selectedSpace
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
