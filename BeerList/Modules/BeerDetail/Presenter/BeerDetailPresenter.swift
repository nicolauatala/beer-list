//
//  BeerDetailPresenter.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 29/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Alamofire
import Localize_Swift

protocol BeerDetailView: NSObjectProtocol {
    
}

class BeerDetailPresenter {
    
    var beerDetail: Beer?
    weak fileprivate var beerDetailView: BeerDetailView?
    
    func attachView(_ view: BeerDetailView){
        beerDetailView = view
    }
    
    func detachView() {
        beerDetailView = nil
    }
    
}
