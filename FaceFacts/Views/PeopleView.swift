//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 12/30/23.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    
    // SwiftData find and fetch the model context from the underlying database, and stores in it.
    @Query var people: [Person]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        if people.isEmpty {
            ContentUnavailableView(
                "No People Found",
                systemImage: "person.slash",
                description: Text("Add somebody with the plus button."))
        } else {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text(person.name)
                    }
                }
                .onDelete(perform: deletePeople)
            }
        }
        
    }
    
    func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            
            modelContext.delete(person)
        }
    }
    
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        // If we use people without the underscore it would mean we're trying to change the array produced by the query, not the query itself.
        _people = Query(filter: #Predicate { person in
            if searchString.isEmpty {
                true
            } else {
                person.name.localizedStandardContains(searchString)
                || person.email.localizedStandardContains(searchString)
                || person.details.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    // Tip: SwiftData evaluates these predicates in the order we write them, so it's generally best to arrange them in an efficient order. That might mean putting faster checks before slower checks, or putting checks that eliminate objects more effectively nearer to the start.
    
}

//#Preview {
//    do {
//        let previewer = try Previewer()
//        return PeopleView()
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}

#Preview {
    PeopleView()
}
