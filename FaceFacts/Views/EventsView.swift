//
//  EventsView.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 1/11/24.
//

import SwiftUI
import SwiftData

struct EventsView: View {
    
    // SwiftData find and fetch the model context from the underlying database, and stores in it.
    @Query var events: [Event]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        if events.isEmpty {
            ContentUnavailableView(
                "No Events Found",
                systemImage: "rectangle.portrait.slash",
                description: Text("Add some with the plus button."))
        } else {
            List {
                ForEach(events) { event in
                    NavigationLink(value: event) {
                        Text(event.name)
                    }
                }
                .onDelete(perform: deleteEvent)
            }
        }
    }
    
    func deleteEvent(at offsets: IndexSet) {
        for offset in offsets {
            let event = events[offset]
            
            modelContext.delete(event)
        }
    }
    
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Event>] = []) {
        // If we use people without the underscore it would mean we're trying to change the array produced by the query, not the query itself.
        _events = Query(filter: #Predicate { event in
            if searchString.isEmpty {
                true
            } else {
                event.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    // Tip: SwiftData evaluates these predicates in the order we write them, so it's generally best to arrange them in an efficient order. That might mean putting faster checks before slower checks, or putting checks that eliminate objects more effectively nearer to the start.
    
}

//#Preview {
//    do {
//        let previewer = try Previewer()
//        return EventsView()
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}

#Preview {
    EventsView()
}
