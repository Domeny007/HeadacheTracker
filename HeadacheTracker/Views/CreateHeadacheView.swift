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
    @State private var showActiveHeadacheAlert: Bool = false

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
                    HStack {
                        Text("Интенсивность")
                        Spacer()
                        Text("\(Int(intensity))")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(width: 38, height: 38)
                            .background(intensityColor, in: .circle)
                            .phaseAnimator(
                                [1, 1.25, 1],
                                trigger: intensity
                            ) { content, scale in
                                content.scaleEffect(scale)
                            } animation: { _ in
                                    .spring(duration: 0.2, bounce: 0.6)
                            }
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
                ) {
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
            .alert("У вас есть активная головная боль", isPresented: $showActiveHeadacheAlert) {
                Button("Завершить", role: .destructive) {
                    guard let entry = makeHeadacheEntry() else { return }

                    store.addAndCloseActive(entry)
                    dismiss()
                }
                Button("Оставить", role: .cancel, action: { })
            } message: {
                Text("При завершении будет создана новая запись")
            }
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
        guard let entry = makeHeadacheEntry() else { return }

        do {
            try store.add(entry)
            dismiss()
        } catch {
            guard let error = error as? HeadacheStoreError else {
                dismiss()
                return
            }

            switch error {
            case .haveActiveHeadache:
                showActiveHeadacheAlert = true
            }
        }
    }

    private func checkButtonIsEnabled() -> Bool {
        return location != nil && character != nil
    }

    private func makeHeadacheEntry() -> HeadacheEntry? {
        guard let location,
              let character
        else { return nil }

        var endedAt: Date? = endedAt
        if stillGoing {
            endedAt = nil
        }

        return HeadacheEntry(
            startedAt: startedAt,
            endedAt: endedAt,
            intensity: Int(intensity),
            location: location,
            character: character,
            note: note
        )
    }
}

#Preview {
    NavigationStack {
        CreateHeadacheView(store: HeadacheStore(entries: HeadacheStore.samples))
    }
}
