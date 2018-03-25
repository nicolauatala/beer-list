//
//  APIManager.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation

struct APIManager {
    #if PRODUCTION
        static let baseURL = "https://api.punkapi.com/v2/"
    #else
        // TODO: change the url of development
        static let baseURL = "https://api.punkapi.com/v2/"
    #endif
}
