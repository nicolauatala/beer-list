//
//  BeerTableViewCell.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 28/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Kingfisher

class BeerTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.setDynamicFont()
        descriptionLabel.setDynamicFont()
        photoImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layoutIfNeeded()
        imageHeightConstraint.constant = UIScreen.main.bounds.height / 8
    }
    
    func populate(with data: Beer){
        nameLabel.text = data.name
        descriptionLabel.text = data.tagline
        
        if let photoURLDescription = data.photoURLDescription {
            photoImageView.kf.setImage(with: photoURLDescription)
        }
        
    }
}
