//
//  BeerDetailTableViewCell.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 29/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class BeerDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
            tagLabel.text = tagline
        }
        if let description = data.description{
            descriptionLabel.text = description
        }
        if let photoURLDescription = data.photoURLDescription {
            photoImageView.kf.setImage(with: photoURLDescription)
        }
    }

}
