//
//  PainCharacter.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 07.10.2026.
//

import Foundation

enum PainCharacter: CaseIterable {
    
    case pressing
    case bursting
    case throbbing
    
    var title: String {
        switch self {
        case .pressing:  "Давящая"
        case .bursting:  "Распирающая"
        case .throbbing: "Пульсирующая"
        }
    }
}
