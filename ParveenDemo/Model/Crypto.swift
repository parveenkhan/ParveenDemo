//
//  Crypto.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//


struct Crypto: Codable {
    let name: String
    let symbol: String
    let type: String
    let isActive: Bool
    let isNew: Bool
    
    // Map JSON keys to Swift properties
        enum CodingKeys: String, CodingKey {
            case name
            case symbol
            case type
            case isActive = "is_active"
            case isNew = "is_new"
        }
}
