//
//  RealmServise.swift
//  PhotoViewer
//
//  Created by  admin on 7.11.22.
//

import RealmSwift

let realm = try? Realm()

class RealmServise {
    
    func realmObjects() -> Results<RealmType>? {
        realm?.objects(RealmType.self)
    }
    
    func saveObject(object: Object?) {
        guard let object = object else { return }

        try? realm?.write {
            realm?.add(object)
        }
    }
    
    func removeObject(object: Object?) {
        guard let object = object else { return }

        try? realm?.write {
            realm?.delete(object)
        }
    }
}

@objcMembers
class RealmType: Object {
    
    dynamic var jsonString: String?
}
