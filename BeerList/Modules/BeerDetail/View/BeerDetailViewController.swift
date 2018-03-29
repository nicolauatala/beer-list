//
//  BeerDetailViewController.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 29/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let beerDetailPresenter = BeerDetailPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerDetailPresenter.attachView(self)
        prepareTableView()
    }
    
    func setBeerDetail(with data: Beer) {
        beerDetailPresenter.beerDetail = data
    }
    
    func prepareTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 260
        tableView.register(UINib(nibName: Constants.TableViewCell.beerDetail, bundle: nil), forCellReuseIdentifier: Constants.TableViewCell.beerDetail)
        tableView.tableFooterView = UIView()
    }

}

extension BeerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let beer = beerDetailPresenter.beerDetail else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.beerDetail, for: indexPath) as! BeerDetailTableViewCell
        cell.populate(with: beer)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension BeerDetailViewController: BeerDetailView {
    
}
