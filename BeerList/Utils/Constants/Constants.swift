//
//  Constants.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation

enum Constants {
    
    enum errorCode: Int {
        case nonRetryCode = 0
        case retryCode = 1
    }
    
    enum TableViewCell {
        static let beer = "BeerTableViewCell"
        static let noResults = "NotFoundTableViewCell"
        static let beerDetail = "BeerDetailTableViewCell"
    }
    
}
