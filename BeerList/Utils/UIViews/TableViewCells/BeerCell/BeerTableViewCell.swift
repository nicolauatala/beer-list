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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layoutIfNeeded()
    }
    
    func populate(with data: Beer){
        
        if let name = data.name{
            nameLabel.text = name
        }
        
        if let tagline = data.tagline{
            descriptionLabel.text = tagline
        }
        
        if let photoURLDescription = data.photoURLDescription {
            photoImageView.kf.setImage(with: photoURLDescription)
        }
        
    }
}
