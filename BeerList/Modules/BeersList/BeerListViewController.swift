//
//  BeerListViewController.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
  
}