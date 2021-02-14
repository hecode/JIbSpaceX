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
        tableView.register(UINib(nibName: listingItemTableViewCellName, bundle: nil), forCellReuseIdentifier: listingItemTableViewCellName)
        
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundView = nil
        
        homeViewModel.launches.bind(to: tableView.rx.items(cellIdentifier: listingItemTableViewCellName, cellType: ListingItemTableViewCell.self)) { index, model, cell in
            cell.config(with: model)
        }
        .disposed(by: disposeBag)
        
        //        homeViewModel.launches.subscribe { _ in
        //            self.homeViewModel.launches ? tableView.setEmptyMessage("No Launches found") :  tableView.removeMessage()
        //        }
//            .disposed(by: DisposeBag())
        
        tableView.rx.modelSelected(Launch.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                
                guard let homeItemDetailsViewController = Constants.Storyboards.mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboards.MainStoryboardIDs.HomeItemDetailsViewController.rawValue) as? HomeItemDetailsViewController else {
                    return
                }
                
                homeItemDetailsViewController.homeItemDetailsViewModel.rocketID = model.rocketID
                
                self.navigationController?.pushViewController(homeItemDetailsViewController, animated: true)
                
            }).disposed(by: disposeBag)
        
        tableView.refreshControl = UIRefreshControl()
        
        tableView.refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    @objc func refresh(refreshControl: UIRefreshControl){
        homeViewModel.resetAndLoadHomeItems()
    }
    
}

// MARK: - UITableViewDelegate -

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            
        case .error(let message):
            tableView.hideActivityIndicator()
            
            let alert = UIAlertController(title: "Request Error", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
        default:
            return
        }
        
    }
    
}
