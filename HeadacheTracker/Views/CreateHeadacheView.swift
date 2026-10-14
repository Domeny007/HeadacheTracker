//
//  CreateHeadacheView.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 14.10.2026.
//

import SwiftUI

struct CreateHeadacheView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var startedAt = Date()
    @State private var stillGoing = true
    @State private var endedAt = Date()
    @State private var intensity: Double = 1
    @State private var location: PainLocation?
    @State private var character: PainCharacter?
    @State private var note: String = ""
    
    let store: HeadacheStore
    
    var body: some View {
        Form {
            Section {
                DatePicker("Начало", selection: $startedAt, in: ...Date())
                
                Toggle("Еще идет", isOn: $stillGoing)
                
                if !stillGoing {
                    DatePicker("Окончание", selection: $endedAt, in: startedAt...)
                }
            } header: {
                Text("Время")
            }
            
            footer: {
                Text("Окончание должно быть не раньше начала")
            }
            Section("Боль") {
                VStack(alignment: .leading) {
                    HStack() {
                        Text("Интенсивность")
                        Spacer()
                        Text("\(Int(intensity))")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(width: 38, height: 38)
                            .background(intensityColor, in: .circle)
                    }
                    
                    Slider(
                        value: $intensity,
                        in: 1...10,
                        step: 1
                    )
                    .tint(intensityColor)
                    HStack {
                        Text("1 — слабая")
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("10 — нестерпимая")
                            .foregroundStyle(.gray)
                    }
                }
                
                Picker(
                    "Локализация",
                    selection: $location
                )
                {
                    ForEach(PainLocation.allCases, id: \.self) { item in
                        Text(item.title)
                            .tag(item)
                    }
                }
                
                Picker(
                    "Характер",
                    selection: $character
                ) {
                    ForEach(PainCharacter.allCases, id: \.self) { item in
                        Text(item.title)
                            .tag(item)
                    }
                }
            }
            
            Section("Заметка") {
                TextField("Не обязательно", text: $note)
            }
        }
        .toolbar {
            Button("Сохранить") {
                saveAndDismiss()
            }
            .disabled(!checkButtonIsEnabled())
        }
    }
    
    
    // FIXME: Привести к общему виду и убрать из HeadacheRow
    
    private var intensityColor: Color {
        switch intensity {
        case ...3:  .green
        case 4...6: .orange
        default:    .red
        }
    }
    
    private func saveAndDismiss() {
        guard let location,
              let character
        else { return }
        
        var endedAt: Date? = endedAt
        if stillGoing {
            endedAt = nil
        }
        
        let entry = HeadacheEntry(
            startedAt: startedAt,
            endedAt: endedAt,
            intensity: Int(intensity),
            location: location,
            character: character,
            note: note
        )
        store.entries.append(entry)
        dismiss()
    }
    
    private func checkButtonIsEnabled() -> Bool {
        return location != nil && character != nil
    }
}

#Preview {
    NavigationStack {
        CreateHeadacheView(store: HeadacheStore())
    }
}
