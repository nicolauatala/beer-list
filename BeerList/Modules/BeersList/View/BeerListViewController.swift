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
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
    
    fileprivate let beerPresenter = BeerPresenter()
    var filteredBeers   = [Beer]()
    var searchActive    : Bool = false
    var favoritesActive : Bool = false
    var searchText      = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerPresenter.attachView(self)
        prepareTableView()
        beerPresenter.getBeerList()
        favoritesButton.title = "FAVORITES".localized()
        self.hideKeyboardWhenTappedAround()
        searchbar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if favoritesActive {
            self.beerPresenter.getFavoritesList()
        }
    }
    
    func prepareTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(UINib(nibName: Constants.TableViewCell.beer, bundle: nil), forCellReuseIdentifier: Constants.TableViewCell.beer)
        tableView.register(UINib(nibName: Constants.TableViewCell.noResults, bundle: nil), forCellReuseIdentifier: Constants.TableViewCell.noResults)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.setNeedsDisplay()
    }
    
    @IBAction func favoritesAction(_ sender: Any) {
        favoritesActive = !favoritesActive
        if self.favoritesActive {
            self.favoritesButton.title = "ALL".localized()
            self.beerPresenter.getFavoritesList()
        } else {
            self.favoritesButton.title = "FAVORITES".localized()
            self.tableView.reloadData()
        }
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
    
    func showFavoritesList() {
        tableView.reloadData()
    }
    
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return self.filteredBeers.count > 0 ? self.filteredBeers.count : 1
        }
        if favoritesActive {
            return self.beerPresenter.favoritesList.count > 0 ? self.beerPresenter.favoritesList.count : 1
        }
        return self.beerPresenter.beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.beer, for: indexPath) as! BeerTableViewCell
        
        if searchActive {
            if filteredBeers.count == 0 {
                return tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.noResults, for: indexPath) as! NotFoundTableViewCell
            }
            cell.populate(with: filteredBeers[indexPath.row])
        } else if favoritesActive {
            if self.beerPresenter.favoritesList.count == 0 {
                return tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.noResults, for: indexPath) as! NotFoundTableViewCell
            }
            cell.populate(with: self.beerPresenter.favoritesList[indexPath.row])
        } else {
            cell.populate(with: self.beerPresenter.beerList[indexPath.row])
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.setNeedsDisplay()
        if !favoritesActive {
            let last = self.beerPresenter.beerList.count - 1
            
            if indexPath.row == last {
                self.beerPresenter.page += 1
                self.beerPresenter.getBeerList()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            beerPresenter.beerSelected = filteredBeers[indexPath.row]
        } else if favoritesActive {
            beerPresenter.beerSelected = beerPresenter.favoritesList[indexPath.row]
        } else {
            beerPresenter.beerSelected = beerPresenter.beerList[indexPath.row]
        }
        performSegue(withIdentifier: "toDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue"{
            if let vc = segue.destination as? BeerDetailViewController {
                if let beer = beerPresenter.beerSelected {
                    vc.setBeerDetail(with: beer)
                }
            }
        }
    }
  
}

extension BeerListViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchActive = false;

        if !searchText.isEmpty {
            var setList = [Beer]()
            setList = favoritesActive == true ? beerPresenter.favoritesList : beerPresenter.beerList
            filteredBeers = setList.filter({( beer : Beer) -> Bool in
                return beer.name.lowercased().contains(searchText.lowercased())
            })
            searchActive = true;
        }
        tableView.reloadData()
    }
}
