//
//  UserGenerator.swift
//  MrPicProject
//
//  Created by 박소현 on 2023/10/02.
//

import Foundation

struct UserGenerator: Codable {
    
    let userList: [User]
    let info: Info
    
    enum CodingKeys : String, CodingKey {
        case userList = "results"
        case info
    }
    
    // MARK: - User
    struct User: Codable {
        
        let name: Name
        let gender, phone, nat: String
        let id: ID
        let picture: Picture
        let login: Login
        let email, cell: String
        let dob: Dob
        let location: Location
        let registered: Dob
        
        // MARK: - Name
        struct Name: Codable {
            let title, last, first: String
        }
        
        // MARK: - ID
        struct ID: Codable {
            let name: String
            let value: String?
        }
        
        // MARK: - Picture
        struct Picture: Codable {
            let medium, thumbnail, large: String
        }
        
        // MARK: - Login
        struct Login: Codable {
            let md5, salt, password, username: String
            let sha1, sha256, uuid: String
        }
        
        // MARK: - Dob
        struct Dob: Codable {
            let date: String
            let age: Int
        }
        
        // MARK: - Location
        struct Location: Codable {
            let city: String
            var postcode: Postcode
            let state, country: String
            let street: Street
            let timezone: Timezone
            let coordinates: Coordinates
            
            // MARK: - Street
            struct Street: Codable {
                let number: Int
                let name: String
            }
            
            // MARK: - Timezone
            struct Timezone: Codable {
                let offset, description: String
            }
            
            // MARK: - Coordinates
            struct Coordinates: Codable {
                let longitude, latitude: String
            }
            
            enum Postcode: Codable {
                case integer(Int)
                case string(String)

                init(from decoder: Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let x = try? container.decode(Int.self) {
                        self = .integer(x)
                        return
                    }
                    if let x = try? container.decode(String.self) {
                        self = .string(x)
                        return
                    }
                    throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
                }

                func encode(to encoder: Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .integer(let x):
                        try container.encode(x)
                    case .string(let x):
                        try container.encode(x)
                    }
                }
            }
        }
    }
    
    // MARK: - Info
    struct Info: Codable {
        let page, results: Int
        let seed, version: String
    }
}
