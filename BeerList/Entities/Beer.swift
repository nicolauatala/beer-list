//
//  Beer.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 23/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

final class Beer: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var descriptionBeer: String = ""
    @objc dynamic var image_url: String = ""
    @objc dynamic var isFavorite: String = "NO"
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var photoURLDescription: URL?{
        if image_url != "" {
            return URL(string: image_url)
        }
        return nil
    }
  
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        tagline         <- map["tagline"]
        descriptionBeer <- map["description"]
        image_url       <- map["image_url"]
    }
    
    func save() {
        DBManager.addObjc(self)
    }
    
    func delete(){
        DBManager.deleteObjc(self)
    }
    
    func isFavorite(bool: Bool){
        do {
            RealmSingleton.shared.realm.beginWrite()
            if bool{
                self.isFavorite = "YES"
            }  else {
                self.isFavorite = "NO"
            }
        }
        try! RealmSingleton.shared.realm.commitWrite()
        DBManager.update(self)
    }
  
}
