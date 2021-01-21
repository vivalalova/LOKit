//
//  URL+.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/11/4.
//

import Foundation

public
extension URL {
    func add(query: [String: String?]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []

        // Create query item
        let items = query.map { URLQueryItem(name: $0, value: $1) }

        // Append the new query item in the existing query items array
        queryItems.append(contentsOf: items)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }

    func add(query: String, forKey: String) -> URL {
        self.add(query: [forKey: query])
    }
}
