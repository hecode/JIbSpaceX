//
//  HomeViewController.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let listingItemTableViewCellName = String(describing: ListingItemTableViewCell.self)
    
    let disposeBag = DisposeBag()
    
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicSetup()
        
        setupTableView()
        
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // if api was cached/saved locally it would be loaded while making the new request
        
        if !checkPoppedBackFromVCToVC(fromControllerType: HomeItemDetailsViewController.self,
                                      toControllerType: HomeViewController.self) {
            tableView.showActivityIndicator()
            homeViewModel.resetAndLoadHomeItems()
        }
    }
    
}

// MARK: - Setup -

extension HomeViewController {
    
    func basicSetup() {
        title = "Filtered Launches"
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: listingItemTableViewCellName, bundle: nil), forCellReuseIdentifier: listingItemTableViewCellName)
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundView = nil
        
        tableView.refreshControl = UIRefreshControl()
        
        tableView.refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    func setupRx() {
        homeViewModel.launches.bind(to: tableView.rx.items(cellIdentifier: listingItemTableViewCellName, cellType: ListingItemTableViewCell.self)) { index, model, cell in
            cell.config(with: model)
            cell.selectionStyle = .none
        }
        .disposed(by: disposeBag)
        
        homeViewModel.launches.subscribe { _ in
            try? self.homeViewModel.launches.value().count < 1 ? self.tableView.setEmptyMessage("No Launches found") : self.tableView.removeMessage()
            
            self.tableView.hideActivityIndicator()
        }
        .disposed(by: disposeBag)
        
        homeViewModel.launches.subscribe(onError: { _ in
            // this could be a general helper alert
            let alert = UIAlertController(title: "Request Error", message: Constants.genericAPIErrorMessage, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil) }
        ).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Launch.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                
                guard let homeItemDetailsViewController = Constants.Storyboards.mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboards.MainStoryboardIDs.HomeItemDetailsViewController.rawValue) as? HomeItemDetailsViewController else {
                    return
                }
                
                homeItemDetailsViewController.homeItemDetailsViewModel.rocketID = model.rocketID
                
                self.navigationController?.pushViewController(homeItemDetailsViewController, animated: true)
                
                }
        ).disposed(by: disposeBag)
    }
    
    @objc func refresh(refreshControl: UIRefreshControl){
        homeViewModel.resetAndLoadHomeItems()
    }
    
}
