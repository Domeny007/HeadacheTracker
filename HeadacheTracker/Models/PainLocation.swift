//
//  PainLocation.swift
//  HeadacheTracker
//
//  Created by Азат Алекбаев on 07.10.2026.
//

import Foundation

enum PainLocation: CaseIterable {
    
    case back
    case forehead
    case temple
    case crownOfTheHead
    case wholeHead
    case half
    
    var title: String {
        switch self {
        case .back:
            "Сзади"
        case .forehead:
            "Лоб"
        case .temple:
            "Виски"
        case .crownOfTheHead:
            "Темя"
        case .wholeHead:
            "Вся голова"
        case .half:
            "Половина"
        }
    }
}
