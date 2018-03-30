//
//  BeerDetailTableViewCell.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 29/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import RealmSwift

class BeerDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteIconButton: UIButton!
    
    var beerObject: Beer?
    var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layoutIfNeeded()
    }
    
    func populate(with data: Beer){
        beerObject = data
        
        let recordedBeer = {
            try! Realm().objects(Beer.self).filter("id == %@ AND isFavorite == %@", data.id, "YES")
        }()
        
        if !recordedBeer.isEmpty {
            favoriteIconButton.setImage(#imageLiteral(resourceName: "heartIcon"), for: .normal)
            isFavorite = true
        }
        
        nameLabel.text = data.name
        tagLabel.text = data.tagline
        descriptionLabel.text = data.descriptionBeer
        
        if let photoURLDescription = data.photoURLDescription {
            photoImageView.kf.setImage(with: photoURLDescription)
        }
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        if isFavorite {
            beerObject?.isFavorite(bool: !isFavorite)
            favoriteIconButton.setImage(#imageLiteral(resourceName: "heartIconNoSelected"), for: .normal)
        } else {
            beerObject?.save()
            beerObject?.isFavorite(bool: !isFavorite)
            favoriteIconButton.setImage(#imageLiteral(resourceName: "heartIcon"), for: .normal)
        }
    }

}
