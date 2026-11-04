//
//  HeadacheTrackerTests.swift
//  HeadacheTrackerTests
//
//  Created by Азат Алекбаев on 04.11.2026.
//

import Testing
import Foundation

@testable import HeadacheTracker

struct HeadacheTrackerTests {
    
    @Test func activeEpisodeExist() {
        let store = makeStoreWithActiveEpisode()
        
        #expect(store.entries.count == 3)
        
        #expect(throws: HeadacheStoreError.haveActiveHeadache) {
            try store.add(makeActiveHeadache())
        }
        
        #expect(store.entries.count == 3)
    }
    
    @Test func activeEpisodeNotExist() throws {
        let store = makeStoreWithoutActiveEpisode()
        
        let headache = makeActiveHeadache()
        
        #expect(store.entries.count == 3)
        
        try store.add(headache)
        
        #expect(store.entries.count == 4)
    }
}


private func makeActiveHeadache() -> HeadacheEntry {
    HeadacheEntry(
        startedAt: Date.now,
        endedAt: nil,
        intensity: 1,
        location: .back,
        character: .bursting,
        note: ""
    )
}

private func makeInactiveHeadache() -> HeadacheEntry {
    HeadacheEntry(
        startedAt: Date.now,
        endedAt: Date.now + 1000,
        intensity: 1,
        location: .back,
        character: .bursting,
        note: ""
    )
}

private func makeStoreWithActiveEpisode() -> HeadacheStore {
    HeadacheStore(
        entries: [
            makeActiveHeadache(),
            makeInactiveHeadache(),
            makeInactiveHeadache()]
    )
}

private func makeStoreWithoutActiveEpisode() -> HeadacheStore {
    HeadacheStore(
        entries: [
            makeInactiveHeadache(),
            makeInactiveHeadache(),
            makeInactiveHeadache()
        ]
    )
}
