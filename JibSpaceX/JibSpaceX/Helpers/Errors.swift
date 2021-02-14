//
//  Errors.swift
//  JibSpaceX
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import Foundation

enum Errors: Error {
    case apiError(String? = Constants.genericAPIErrorMessage)
}
