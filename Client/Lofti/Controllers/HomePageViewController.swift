//
//  ViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/1/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import UIKit


protocol SpaceData{
    func passSpaceData(space: Space?)
}

class HomePageViewController: UIViewController {

//    var spaceDelegate: SpaceData!
//    var spaces: Result?{
//        didSet{
//            DispatchQueue.main.async {
//                self.spaceListTableView.reloadData()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.title = "Spaces"
        self.spaceListTableView.delegate = self as? UITableViewDelegate
        self.spaceListTableView.dataSource = self as? UITableViewDataSource
        
        view.addSubview(spaceListTableView)
        spaceListTableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: Constants.homePageCellID)
        //makeApiRequest()
        anchorTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.spaceListTableView.reloadData()
        }
    }
    

//    fileprivate func makeApiRequest(){
//        SpaceServices.index { (spaces) in
//            if let spaces = spaces{
//                self.spaces = spaces
//            }
//        }
//    }
    
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = spaceListTableView.dequeueReusableCell(withIdentifier: Constants.homePageCellID, for: indexPath) as! HomePageTableViewCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let spaces = spaces{
//            let destinationVC = SpaceDetailsViewController() as SpaceDetailsViewController
//            let selectedSpace = spaces.businesses[indexPath.row]
//            spaceDelegate.passSpaceData(space: selectedSpace)
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        }
    }
}
