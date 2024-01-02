//
//  Previewer.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 1/1/24.
//

import Foundation
import SwiftData

@MainActor
// Because SwiftData's main context always runs on the main actor,
// we need to annotate the whole struct with @MainActor to ensure it also runs there.

struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // Making SwiftData store its data in memory means using ModelConfiguration. This has various useful options, but right now all we care about is that it's not storing data permanently.
        
        container = try ModelContainer(for: Person.self, configurations: config)
        // Creating a model container ourselves is a throwing operation,
        // so I've made the whole initializer throwing rather than try to handle errors here.
        
        event = Event(name: "Dimension Jump", location: "Nottingham", date: .now)
        person = Person(name: "Dave Lister", email: "dave@reddwarf.com", details: "", metAt: event)
        // The container, person, and event are all stored in properties for easier external access.
        // I've made them all constants because it doesn't make sense to change them once they have been created.
        
        container.mainContext.insert(person)
    }
}
