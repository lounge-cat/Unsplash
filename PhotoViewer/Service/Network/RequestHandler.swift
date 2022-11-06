//
//  RequestHandler.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class RequestHandler {
    
    private func headers() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID blEZijDXtI-6CKxlsAjcbAvJekqbnBKXZw6uZF2FZOc"
        return headers
    }
    
    func urlRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers()
        request.httpMethod = "get"
        return request
    }
    
    func searchParameters(searchText: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchText
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    func randomParameters() -> [String: String] {
        var parameters = [String: String]()
        parameters["count"] = String(30)
        return parameters
    }
    
    func url(parameters: [String: String], path: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    func task(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
