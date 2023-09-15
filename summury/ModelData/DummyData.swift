//
//  DummyData.swift
//  summury
//
//  Created by Zuka Papuashvili on 14.09.23.
//

import Foundation

struct DummyData: Codable {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
