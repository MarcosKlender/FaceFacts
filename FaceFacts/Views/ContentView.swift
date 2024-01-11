//
//  ContentView.swift
//  FaceFacts
//
//  Created by Klender Carrasco on 12/28/23.
//  http://tinyurl.com/yoeoyf2y
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            PeopleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("FaceFacts")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person, navigationPath: $path)
                }
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Person.name)])
                            
                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Person.name, order: .reverse)])
                        }
                    }
                    // Tip: Wrapping the Picker in a Menu means we get a nice sort icon in the navigation bar, rather than seeing "Name (A-Z)" up there.
                    
                    Button("Add Person", systemImage: "plus", action: addPerson)
                }
                .searchable(text: $searchText)
            
        }
    }
    
    func addPerson() {
        let person = Person(name: "", email: "", details: "")
        
        modelContext.insert(person)
        
        path.append(person)
        
    }
    
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
