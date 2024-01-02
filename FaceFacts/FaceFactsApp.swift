//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 12/28/23.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // SwiftData silently created a model context for us to use called "The Main Context"
        .modelContainer(for: Person.self)
    }
}
