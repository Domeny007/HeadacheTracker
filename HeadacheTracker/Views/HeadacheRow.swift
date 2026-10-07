//
//  HeadacheRow.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 07.10.2026.
//

import SwiftUI

struct HeadacheRow: View {
    
    let entry: HeadacheEntry
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(entry.intensity)")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(width: 38, height: 38)
                .background(intensityColor, in: .circle)
            
            VStack(alignment: .leading) {
                
                Text(entry.character.title)
                    .font(.headline)
                
                Text(entry.location.title)
                    .font(.subheadline)
                
                if !entry.note.isEmpty {
                    Text(entry.note)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(
                    entry.startedAt,
                    format: .dateTime
                        .day()
                        .month(.abbreviated)
                )
                
                if entry.isActive {
                    Text("идёт")
                        .font(.caption2.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.red, in: .capsule)
                } else if let duration = entry.duration {
                    Text(durationText(duration))
                        .font(.caption.bold())
                }
            }
        }
    }
    
    private var intensityColor: Color {
        switch entry.intensity {
        case ...3:  .green
        case 4...6: .orange
        default:    .red
        }
    }
    
    private func durationText(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        return hours > 0 ? "\(hours) ч \(minutes) мин" : "\(minutes) мин"
    }
}

#Preview {
    HeadacheRow(entry: HeadacheStore.samples[0])
}
