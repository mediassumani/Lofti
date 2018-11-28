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
                self.collectionView.reloadData()
            }
        }
    }
    weak var spaceDelegate: SpaceDelegate?
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.title = "Spaces"
//        self.collectionView.delegate = self as UITableViewDelegate
//        self.collectionView.dataSource = self as UITableViewDataSource
        
        //view.addSubview(collectionView)
       // collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        fetchSpaces()
        //anchorCollectionView()
        setUpNavigationBarItems()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
//    }
    
    /// Sets up home page title and nav bar items
    fileprivate func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = "Spaces Nearby"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Rockwell", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
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
    
    fileprivate func anchorCollectionView(){
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
//    func anchorTableView(){
//        spaceListTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
//    }
    
//    let spaceListTableView: UITableView = {
//
//        let tableview = UITableView()
//        tableview.backgroundColor = .clear
//        tableview.translatesAutoresizingMaskIntoConstraints = false
//        return tableview
//    }()
    
    lazy var collectionView: UICollectionView = {
        
        // Instantiating the UICollectionView, using the default flow layout
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Setting the datasource & delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        // Customization
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        
        //Registering the cell
        collectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: HomePageCollectionViewCell.identifier)
        
        return collectionView
    }()
}

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return spaces.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = spaceListTableView.dequeueReusableCell(withIdentifier: Constants.homePageCellID, for: indexPath) as! HomePageTableViewCell
//
//        let selectedSpace = spaces[indexPath.row]
//        cell.spaceNameLabel.text = selectedSpace.name ?? "Unknown"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let destinationVC = SpaceDetailsViewController() as SpaceDetailsViewController
//        let selectedSpace = spaces[indexPath.row]
//        //destinationVC.spaceDelegate = self as? SpaceDelegate
//        //spaceDelegate?.passSpaceData(space: selectedSpace)
//        destinationVC.space = selectedSpace
//        self.navigationController?.pushViewController(destinationVC, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = SpaceDetailsViewController() as SpaceDetailsViewController
        let selectedSpace = spaces[indexPath.row]
        //destinationVC.spaceDelegate = self as? SpaceDelegate
        //spaceDelegate?.passSpaceData(space: selectedSpace)
        destinationVC.space = selectedSpace
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageCollectionViewCell.identifier, for: indexPath) as! HomePageCollectionViewCell
        let currentSpace = spaces[indexPath.row]
        cell.textLabel.text = currentSpace.name
        
        return cell
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth/2.14, height: screenWidth/2)
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
        return 5
    }

}
