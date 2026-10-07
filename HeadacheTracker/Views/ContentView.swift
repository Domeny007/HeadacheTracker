//
//  ContentView.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 07.10.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var store = HeadacheStore()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.entries) { entry in
                    HeadacheRow(entry: entry)
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                }
            }
            .navigationTitle("Трекер головной боли")
        }
    }
}

#Preview {
    ContentView()
        .environment(\.locale, Locale(identifier: "ru_RU"))
}
