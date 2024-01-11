//
//  Person.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 12/29/23.
//

import Foundation
import SwiftData

// MARK: - Model Container

@Model
class Person {
    
    @Attribute(.externalStorage) var photo: Data?

    var name: String
    var email: String
    var details: String
    
    var metAt: Event?
    // Tip: I've made metAt optional because it won't have a value initially.
    // Users will need to select an event while editing the user.
    
    init(name: String, email: String, details: String, metAt: Event? = nil) {
        self.name = name
        self.email = email
        self.details = details
        self.metAt = metAt
    }
}
