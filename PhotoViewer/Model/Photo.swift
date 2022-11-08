//
//  Model.swift
//  UnsplashMVVM
//
//  Created by  admin on 21.10.22.
//

import Foundation

class Photo: Codable, Equatable {
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    let width: Int
    let height: Int
    let user: User
    let downloads: Int?
    let created_at: String?
    let urls: Urls
    var id: String?
}

struct User: Codable {
    let name: String?
    let location: String?
}

struct Urls: Codable {
    let regular: String?
    let thumb: String?
}

struct SearchResults: Decodable {
    let total: Int
    let results: [Photo]
}
