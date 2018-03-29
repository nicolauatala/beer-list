//
//  BeerPresenter.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 28/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Alamofire
import Localize_Swift

protocol BeerView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func showBeerList()
    func showMessage(_ title: String, _ message: String)
}

class BeerPresenter {
    
    weak fileprivate var beerView: BeerView?
    
    var page: Int = 1
    var getBeerRequest: Request?
    var beerList = [Beer]()
    var beerSelected: Beer?
    
    func attachView(_ view: BeerView){
        beerView = view
    }
    
    func detachView() {
        beerView = nil
    }
    
    func getBeerList(){
        getBeerRequest?.cancel()
        self.beerView?.startLoading()
        getBeerRequest = APIManager.getRepositories(page: page, success: {[weak self] (beers) in
            self?.beerView?.finishLoading()
            if let strongSelf = self {
                strongSelf.beerList.append(contentsOf: beers)
                self?.beerView?.showBeerList()
                self?.beerView?.finishLoading()
            }
        }, failure: { (error) in
            self.beerView?.finishLoading()
            self.beerView?.showMessage("TITLE_ERROR".localized(), "MESSAGE_WRONG".localized())
        })
    }
    
    deinit {
        getBeerRequest?.cancel()
    }
}
