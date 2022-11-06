//
//  RequestService.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class RequestService {

    private let requestHandler = RequestHandler()
    
    func networkResultsFromSearch(searchText: String, completion: @escaping (Data?, Error?) -> ()) {
        let url = requestHandler.url(
            parameters: requestHandler.searchParameters(searchText: searchText),
            path: "/search/photos")
        
        let request = requestHandler.urlRequest(url: url)
        requestHandler.task(request: request, completion: completion).resume()
    }
    
    func randomNetworkResults(completion: @escaping (Data?, Error?) -> ()) {
        let url = requestHandler.url(
            parameters: requestHandler.randomParameters(),
            path: "/photos/random")
        
        let request = requestHandler.urlRequest(url: url)
        requestHandler.task(request: request, completion: completion).resume()
    }
}
