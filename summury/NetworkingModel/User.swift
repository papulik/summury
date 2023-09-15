//
//  User.swift
//  summury
//
//  Created by Zuka Papuashvili on 15.09.23.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    // Add other properties as needed
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    // Add other properties as needed
}
