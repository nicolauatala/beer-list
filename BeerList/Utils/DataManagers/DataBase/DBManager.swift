//
//  DBManager.swift
//  BeerList
//
//  Created by Nicolau Atala Pelluzi on 29/03/18.
//  Copyright © 2018 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

struct DBManager {
    
    static func addObjc(_ obj: Object){
        try! Realm().write(){
            try! Realm().add(obj)
        }
    }
    
    static func getByCondition <T: Object>(param: String, value: String) -> T {
        let obj: Results<T> = {
            try! Realm().objects(T.self).filter("\(param) == %@", value)
        }()
        
        if obj.isEmpty {
            return T()
        } else {
            return obj.first!
        }
    }
    
    static func getByPrimaryKey <T: Object>(value: String) -> T {
        
        let obj: T? = {
            try! Realm().object(ofType: T.self, forPrimaryKey: value)
        }()
        
        if obj == nil  {
            return T()
        } else {
            return obj!
        }
    }
    
    static func getAll<T : Object>() -> [T] {
        let objs: Results<T> = {
            try! Realm().objects(T.self)
        }()
        
        return Array(objs)
    }
    
    static func deleteObjc(_ obj: Object){
        try! Realm().write(){
            try! Realm().delete(obj)
        }
    }
    
    static func deleteAllDatas() {
        try! Realm().write(){
            try! Realm().deleteAll()
        }
    }
    
    static func update(_ obj: Object){
        try! Realm().write(){
            try! Realm().add(obj, update: true)
        }
    }
}
