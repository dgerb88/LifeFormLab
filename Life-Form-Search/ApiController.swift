//
//  ApiController.swift
//  Life-Form-Search
//
//  Created by Dax Gerber on 1/8/24.
//

import Foundation

protocol APIRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeData(_ data: Data) throws -> Response
}

enum APIError: Error {
    case youSuck
}

struct LifeFormAPIRequest: APIRequest {
    var searchTerm: String
    var urlRequest: URLRequest {
        var components = URLComponents(string: "https://eol.org/api/search/1.0.json")!
        let searchItem = URLQueryItem(name: "q", value: searchTerm)
        components.queryItems = [searchItem]
        return URLRequest(url: components.url!)
    }
    
    func decodeData(_ data: Data) throws -> LifeForms {
        let decoder = JSONDecoder()
        return try decoder.decode(LifeForms.self, from: data)
    }
}

struct Pages: APIRequest {
    var id: Int
    var urlRequest: URLRequest {
        var url = URL(string: "https://eol.org/api/pages/1.0/\(id).json?taxonomy=true&images_per_page=1&language=en")
        return URLRequest(url: url!)
    }
    
    func decodeData(_ data: Data) throws -> Page {
        let decoder = JSONDecoder()
        return try decoder.decode(
            Page.self, from: data)
    }
}



extension Data {
    func prettyPrintedJSONString() {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to read JSON Object.")
            return
        }
        print(prettyJSONString)
    }
}
