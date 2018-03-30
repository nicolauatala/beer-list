//
//  NotFoundTableViewCell.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 29/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class NotFoundTableViewCell: UITableViewCell {

    @IBOutlet weak var noResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noResult.setDynamicFont()
    }
}
