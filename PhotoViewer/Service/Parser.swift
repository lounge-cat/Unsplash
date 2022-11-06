//
//  Parser.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class Parser {
    
    func decodeJSON<T: Decodable>(data: Data?, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        guard
            let data = data
        else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print("Error decode JSON: \(error)")
            return nil
        }
    }
    
    func encodeJSON<T: Encodable>(object: T) -> String? {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(object)
            return String(data: data, encoding: .utf8)
        } catch let error {
            print(("Error encode object: \(error)"))
            return nil
        }
    }
}
