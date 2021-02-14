//
//  HomeViewController.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let listingItemTableViewCellName = String(describing: ListingItemTableViewCell.self)
    
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicSetup()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // if api was cached/saved locally it would be loaded while making the new request
        
        if !checkPoppedBackFromVCToVC(fromControllerType: HomeItemDetailsViewController.self,
                                      toControllerType: HomeViewController.self) {
            homeViewModel.resetAndLoadHomeItems()
        }
    }
    
}

// MARK: - Setup -

extension HomeViewController {
    
    func basicSetup() {
        title = "Filtered Launches"
        
        homeViewModel.delegate = self
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: listingItemTableViewCellName, bundle: nil), forCellReuseIdentifier: listingItemTableViewCellName)
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundView = nil
        
        tableView.refreshControl = UIRefreshControl()
        
        tableView.refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    @objc func refresh(refreshControl: UIRefreshControl){
        homeViewModel.resetAndLoadHomeItems()
    }
    
    func emptyListMessageChecker() {
        if homeViewModel.getLaunchesCount() == 0 {
            tableView.setEmptyMessage("No Launches found")
        } else {
            tableView.removeMessage()
        }
    }
    
}

// MARK: - UITableViewDataSource -

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeViewModel.getLaunchesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: listingItemTableViewCellName) as? ListingItemTableViewCell {
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            if let productItem = homeViewModel.launchItemForRow(row: indexPath.row) {
                cell.config(with: productItem)
            }
            
            return cell
        } else {
            return tableView.defaultCell()
        }
    }
    
}

// MARK: - UITableViewDelegate -

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let homeItemDetailsViewController = Constants.Storyboards.mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboards.MainStoryboardIDs.HomeItemDetailsViewController.rawValue) as? HomeItemDetailsViewController else {
            return
        }
        
        guard let launch = homeViewModel.launchItemForRow(row: indexPath.row) else {
            return
        }
        
        print(launch.rocketID)
        homeItemDetailsViewController.homeItemDetailsViewModel.rocketID = launch.rocketID
        
        self.navigationController?.pushViewController(homeItemDetailsViewController, animated: true)
    }
    
}

// MARK: - ViewModelUIDelegate -

extension HomeViewController: ViewModelUIDelegate {
    
    func updateUI(data: Any?, status: StatusEnum?, actionSource: String?) {
        tableView.refreshControl?.endRefreshing()
        
        guard let status = status else { return }
        
        switch status {
        case .fetching:
            tableView.showActivityIndicator()
            
        case .success:
            tableView.hideActivityIndicator()
            tableView.reloadData()
            
            emptyListMessageChecker()
            
        case .error(let message):
            tableView.hideActivityIndicator()
            tableView.reloadData()
            
            emptyListMessageChecker()
            
            let alert = UIAlertController(title: "Request Error", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
        default:
            return
        }
        
    }
    
}
