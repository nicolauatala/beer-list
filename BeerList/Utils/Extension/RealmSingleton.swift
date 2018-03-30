//
//  RealmSingleton.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 30/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmSingleton {
    private init() { }
    static let shared = RealmSingleton()
    var realm = try! Realm()
    
}

