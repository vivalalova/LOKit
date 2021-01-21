//
//  Encode.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/12/18.
//

import Foundation

//extension Encodable {
//    var dictionary: [String: Any]? {
//        guard let data = try? JSONEncoder().encode(self) else { return nil }
//        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//    }
//}
//
//extension Decodable {
//    static func model(from dict: [String: Any]) -> Self? {
//        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
//            return nil
//        }
//
//        return try? JSONDecoder().decode(Self.self, from: data)
//    }
//}
//
//extension Dictionary where Key == String, Value: Any {
//    func object<T: Decodable>() -> T? {
//        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
//            return nil
//        }
//
//        return try? JSONDecoder().decode(T.self, from: data)
//    }
//}
