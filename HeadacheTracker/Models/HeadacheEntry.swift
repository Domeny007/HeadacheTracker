//
//  HeadacheEntry.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 07.10.2026.
//

import Foundation

struct HeadacheEntry: Identifiable {
    
    let id: UUID
    var startedAt: Date
    var endedAt: Date?
    var intensity: Int
    var location: PainLocation
    var character: PainCharacter
    var note: String
    
    var duration: TimeInterval? { endedAt?.timeIntervalSince(startedAt) }
    var isActive: Bool { endedAt == nil }
    
    init(
        id: UUID = UUID(),
        startedAt: Date,
        endedAt: Date?,
        intensity: Int,
        location: PainLocation,
        character: PainCharacter,
        note: String
    ) {
        self.id = id
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.intensity = intensity
        self.location = location
        self.character = character
        self.note = note
    }
}
