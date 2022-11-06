//
//  NetworkService.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class NetworkService {
    
    private let requestService = RequestService()
    private let parser = Parser()
    
    func networkResultsFromSearch(searchText: String, completion: @escaping ([MyType]?) -> ()) {
        requestService.networkResultsFromSearch(searchText: searchText) { data, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(nil)
            }
            
            let parse = self.parser.decodeJSON(data: data, type: SearchResults.self)
            completion(parse?.results)
        }
    }
    
    func randomNetworkResults(completion: @escaping ([MyType]?) -> ()) {
        requestService.randomNetworkResults { data, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(nil)
            }
            
            if let parse = self.parser.decodeJSON(data: data, type: [MyType].self) {
                completion(parse)
            }
        }
    }
    
    func imageData(urlString: String) -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            print("Error: \(error)")
            return nil
        }
    }
}
