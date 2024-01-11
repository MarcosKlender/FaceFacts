//
//  EventsTabView.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 1/11/24.
//

import SwiftUI

struct EventsTabView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Event.name)]
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            EventsView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("Events")
                .navigationDestination(for: Event.self) { event in
                    EditEventView(event: event)
                }
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Event.name)])
                            
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Event.name, order: .reverse)])
                        }
                    }
                    // Tip: Wrapping the Picker in a Menu means we get a nice sort icon in the navigation bar, rather than seeing "Name (A-Z)" up there.
                    
                    Button("Add Person", systemImage: "plus", action: addEvent)
                }
                .searchable(text: $searchText)
            
        }
    }
    
    func addEvent() {
        let event = Event(name: "", location: "", date: .now)
        
        modelContext.insert(event)
        
        path.append(event)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EventsTabView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

