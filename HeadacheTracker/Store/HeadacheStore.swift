//
//  HeadacheStore.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 07.10.2026.
//

import SwiftUI

@Observable
final class HeadacheStore {
    
    var entries = HeadacheStore.samples
    
    static let samples: [HeadacheEntry] = [
        // идёт прямо сейчас
            HeadacheEntry(
                startedAt: .now.addingTimeInterval(-2 * 3600),
                endedAt: nil,
                intensity: 7,
                location: .temple,
                character: .throbbing,
                note: "Началось после долгого экрана"
            ),

            // вчера, 4 часа
            HeadacheEntry(
                startedAt: .now.addingTimeInterval(-26 * 3600),
                endedAt: .now.addingTimeInterval(-22 * 3600),
                intensity: 4,
                location: .forehead,
                character: .pressing,
                note: ""
            ),

            // позавчера, 40 минут
            HeadacheEntry(
                startedAt: .now.addingTimeInterval(-50 * 3600),
                endedAt: .now.addingTimeInterval(-49.3 * 3600),
                intensity: 2,
                location: .back,
                character: .pressing,
                note: "После сна"
            ),

            // неделю назад, тяжёлый
            HeadacheEntry(
                startedAt: .now.addingTimeInterval(-7 * 24 * 3600),
                endedAt: .now.addingTimeInterval(-7 * 24 * 3600 + 9 * 3600),
                intensity: 9,
                location: .half,
                character: .throbbing,
                note: "Светобоязнь, тошнота"
            )
    ]
}
