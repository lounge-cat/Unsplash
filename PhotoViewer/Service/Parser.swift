//
//  Parser.swift
//  PhotoViewer
//
//  Created by  admin on 5.11.22.
//

import Foundation

class Parser {
    
    func decodeJSON<T: Decodable>(string: String?, type: T.Type) -> T? {
        guard let string = string else { return nil }
        return decodeJSON(data: Data(string.utf8), type: type)
    }
    
    func decodeJSON<T: Decodable>(data: Data?, type: T.Type) -> T? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        
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
