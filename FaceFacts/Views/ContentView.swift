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
    
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PeopleTabView()
                .tabItem {
                    Text("People")
                    Image(systemName: "person.fill")
                }
                .tag(1)
            
            EventsTabView()
                .tabItem {
                    Text("Events")
                    Image(systemName: "list.clipboard.fill")
                }
                .tag(2)
        }
    }
    
}

#Preview {
    ContentView()
}
