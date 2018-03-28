//
//  Beer.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import ObjectMapper

class Beer: Mappable {

    var name: String?
    var tagline: String?
    var description: String?
    var image_url: String?
    
    var photoURLDescription: URL?{
        if let image_url = image_url{
            return URL(string: image_url)
        }
        return nil
    }
  
    init() {}

    required init?(map: Map) {
    mapping(map: map)
    }

    func mapping(map: Map) {
    name        <- map["name"]
    tagline     <- map["tagline"]
    description <- map["description"]
    image_url   <- map["image_url"]
}
  
}
