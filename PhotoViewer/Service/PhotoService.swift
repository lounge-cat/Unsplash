//
//  PhotoService.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class PhotoService {
    
    func getFavouritPhotos() -> [MyType] {
        guard
            let results = getData()
        else { return [] }
        
        let jsons = getJsons(results: results)
        let data = getData(objects: jsons)
        return getMyType(data: data)
    }
    
    func deleteFavouritPhoto(indexPath: IndexPath) {
        let object = realmManager.getResults()?[index]
        realmManager.removeObject(object: object)
    }
}
