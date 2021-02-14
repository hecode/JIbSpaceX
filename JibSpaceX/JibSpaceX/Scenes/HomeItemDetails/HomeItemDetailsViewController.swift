//
//  HomeItemDetailsViewController.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit
import ImageSlideshow
import RxSwift
import RxCocoa

class HomeItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    let homeItemDetailsViewModel = HomeItemDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicSetup()
        
        setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.startAnimating()
        homeItemDetailsViewModel.loadRocket(id: homeItemDetailsViewModel.rocketID)
    }
    
}

// MARK: - Setup -

extension HomeItemDetailsViewController {
    
    func basicSetup() {
        title = "Rocket Details"
    }
    
    func setupRx() {
        wikipediaButton.rx.tap.subscribe({ _ in
            if let rocket = try? self.homeItemDetailsViewModel.rocket.value(), let url = URL(string: rocket.wikipediaURL) {
                UIApplication.shared.open(url)
            }
        }).disposed(by: disposeBag)
        
        homeItemDetailsViewModel.rocket.map{$0.name}.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        homeItemDetailsViewModel.rocket.map{$0.description}.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        
        // Will show a slideshow if there are multiple images.
        homeItemDetailsViewModel.rocket.subscribe(onNext: { _ in
            self.setupSlideshow()
            self.activityIndicatorView.stopAnimating()
        }, onError: { _ in
            // this could be a general helper alert
            let alert = UIAlertController(title: "Request Error", message: Constants.genericAPIErrorMessage, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil) }
        ).disposed(by: disposeBag)
    }
    
    func setupSlideshow() {
        imageSlideshow.setImageInputs(homeItemDetailsViewModel.media)
        
        imageSlideshow.isHidden = imageSlideshow.images.count == 0
        
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.circular = false
        imageSlideshow.pageIndicator?.view.isHidden = imageSlideshow.images.count == 1
    }
    
}
