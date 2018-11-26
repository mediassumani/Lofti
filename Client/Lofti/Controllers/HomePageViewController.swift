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

class HomePageViewController: UIViewController {

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.spaceListTableView.reloadData()
        }
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
        //spaceDelegate?.passSpaceData(space: selectedSpace)
        destinationVC.space = selectedSpace
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
