//
//  Event.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 1/1/24.
//

import Foundation
import SwiftData

// MARK: - Model Container

@Model
class Event {
    var name: String
    var location: String
    var date: Date
    
    var people = [Person]()
    
    init(name: String, location: String, date: Date) {
        self.name = name
        self.location = location
        self.date = date
    }
}
