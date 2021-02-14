//
//  ListingItemTableViewCell.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import UIKit

class ListingItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var launchNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    
    // in a real application the non-value labels would also need outlets for localizable strings
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        separatorView.backgroundColor = Constants.Colors.grayColor
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        upcomingLabel.text = nil
        upcomingView.backgroundColor = UIColor.systemRed
        launchNumberLabel.text = nil
        dateLabel.text = nil
        detailsLabel.text = nil
        
        nameLabel.isHidden = false
        upcomingView.isHidden = false
        launchNumberLabel.superview?.isHidden = false
        dateLabel.superview?.isHidden = false
        detailsLabel.superview?.isHidden = false
    }
    
    func config(with listingItem: ListingItemCellProtocol) {
        if listingItem.name.isEmpty {
            self.nameLabel.isHidden = true
        } else {
            self.nameLabel.text = listingItem.name
        }
        
        if let upcoming = listingItem.upcoming {
            self.upcomingLabel.text = upcoming ? "Upcoming" : "No upcoming"
            self.upcomingView.backgroundColor = upcoming ? UIColor.systemGreen : UIColor.systemRed
        } else {
            self.upcomingView.isHidden = true
        }
        
        if listingItem.launchNumber == 0 {
            self.launchNumberLabel.superview?.isHidden = true
        } else {
            self.launchNumberLabel.text = String(listingItem.launchNumber)
        }
        
        if let date = listingItem.date {
            self.dateLabel.text = getFormattedDate(date: date,
                                                   format: DateFormat.yearMonthDayTime)
        } else {
            self.dateLabel.superview?.isHidden = true
        }
        
        if listingItem.details.isEmpty {
            detailsLabel.superview?.isHidden = true
        } else {
            self.detailsLabel.text = listingItem.details
        }
        
    }
    
}
