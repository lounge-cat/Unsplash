//
//  PhotoService.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation
import RealmSwift

class PhotoService {
    
    private let realmService = RealmServise()
    private let parser = Parser()

    func favouritPhotos() -> [Photo] {
        let realmObjects = realmService.realmObjects()
        let jsons = realmObjects?.map { $0.jsonString }
        let photos = jsons?.compactMap { self.parser.decodeJSON(string: $0, type: Photo.self) }
        guard let photos = photos else { return [] }
        return Array(photos)
    }
    
    func savePhotoToFavourits(photo: Photo) {
        let json = parser.encodeJSON(object: photo)
        let realmObject = RealmType()
        realmObject.jsonString = json
        realmService.saveObject(object: realmObject)
    }
    
    func findPhotoInFavourits(photo: Photo) -> Int? {
        let photos = favouritPhotos()
        guard let index = photos.firstIndex(of: photo) else { return nil }
        return Int(index)
    }
    
    func deletePhotoFromFavourits(index: Int) {
        let object = realmService.realmObjects()?[index]
        realmService.removeObject(object: object)
    }
}
