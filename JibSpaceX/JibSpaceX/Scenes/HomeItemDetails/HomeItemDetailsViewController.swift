//
//  HomeItemDetailsViewController.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomeItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func wikipediaAction(_ sender: UIButton) {
        if let url = URL(string: homeItemDetailsViewModel.rocket?.wikipediaURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    let homeItemDetailsViewModel = HomeItemDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homeItemDetailsViewModel.loadRocket(id: homeItemDetailsViewModel.rocketID)
    }
    
}

// MARK: - Setup -

extension HomeItemDetailsViewController {
    
    func basicSetup() {
        title = "Rocket Details"
        
        homeItemDetailsViewModel.delegate = self
    }
    
    func setupData() {
        nameLabel.text = homeItemDetailsViewModel.rocket?.name
        descriptionLabel.text = homeItemDetailsViewModel.rocket?.description
        
        // Will show a slideshow if there are multiple images. at the moment in the api there is only one
        imageSlideshow.setImageInputs(homeItemDetailsViewModel.media)
        
        imageSlideshow.isHidden = imageSlideshow.images.count == 0
        
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.circular = false
        imageSlideshow.pageIndicator?.view.isHidden = imageSlideshow.images.count == 1
    }
    
}

// MARK: - ViewModelUIDelegate -

extension HomeItemDetailsViewController: ViewModelUIDelegate {
    
    func updateUI(data: Any?, status: StatusEnum?, actionSource: String?) {        
        guard let status = status else { return }
        
        switch status {
        case .fetching:
            activityIndicatorView.startAnimating()
            
        case .success:
            activityIndicatorView.stopAnimating()
            setupData()
            
        case .error(let message):
            activityIndicatorView.stopAnimating()
            
            let alert = UIAlertController(title: "Request Error", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
            
        default:
            return
        }
        
    }
    
}
