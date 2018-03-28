//
//  BeerListViewController.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Alamofire
import Localize_Swift
import PKHUD

class BeerListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let beerPresenter = BeerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerPresenter.attachView(self)
        prepareTableView()
        beerPresenter.getBeerList()
    }
    
    func prepareTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(UINib(nibName: Constants.TableViewCell.beer, bundle: nil), forCellReuseIdentifier: Constants.TableViewCell.beer)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.setNeedsDisplay()
    }

}

//MARK: Protocol BeerView
extension BeerListViewController: BeerView {
    func startLoading() {
        DispatchQueue.main.async {
            HUD.show(.rotatingImage((UIImage(named: "progress"))))
        }
    }
    
    func finishLoading() {
        PKHUD.sharedHUD.hide(afterDelay: 0.1)
    }
    
    func showBeerList() {
        tableView.reloadData()
        if beerPresenter.page == 1 {
            tableView.animateCellTableView()
        }
    }
    
    func showMessage(_ title: String, _ message: String) {
        let action = UIAlertAction(title: "OK".localized(), style: .default, handler: nil)
        UIAlertController.presentAlertInViewController(self, title: title, message: message, actions: [action], completion: nil)
    }
    
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerPresenter.beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.beer, for: indexPath) as! BeerTableViewCell
        
        cell.populate(with: self.beerPresenter.beerList[indexPath.row])
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let last = self.beerPresenter.beerList.count - 1
        
        if indexPath.row == last {
            self.beerPresenter.page += 1
            self.beerPresenter.getBeerList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ""{
           
        }
    }
  
}
