//
//  AbstractViewModel.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation

protocol ViewModelUIDelegate: class {

    /// UpdateUI
    /// - Parameters:
    ///   - data: can be sent if needed
    ///   - status: success, fetching, error, dismiss
    ///   - actionSource: can use string enums to differentiat multiple actions in the same view for different actions
    func updateUI(data: Any?, status: StatusEnum?, actionSource: String?)
    
}

class AbstractViewModel: NSObject {
    
    weak var delegate: ViewModelUIDelegate?
}
