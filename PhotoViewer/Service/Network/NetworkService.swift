//
//  NetworkService.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class NetworkService {
    
    func getImageData(string: String) -> Data? {
        guard
            let url = getUrl(string: string)
        else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            print("Error: \(error)")
            return nil
        }
    }
}
