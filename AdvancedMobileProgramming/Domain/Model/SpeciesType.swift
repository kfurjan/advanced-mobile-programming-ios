//
//  SpeciesType.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation

enum SpeciesType: String, CaseIterable, Identifiable, Localizable {
    var id: String { self.rawValue }
    case all, human, animal, alien, mythological, robot, cronenberg, unknown

    var localizedDescription: String {
        switch self {
        case .all:
            return NSLocalizedString("All", comment: "All SpeciesType")
        case .human:
            return NSLocalizedString("Human", comment: "Human SpeciesType")
        case .animal:
            return NSLocalizedString("Animal", comment: "Animal SpeciesType")
        case .alien:
            return NSLocalizedString("Alien", comment: "Alien SpeciesType")
        case .mythological:
            return NSLocalizedString("Mythological", comment: "Mythological SpeciesType")
        case .robot:
            return NSLocalizedString("Robot", comment: "Robot SpeciesType")
        case .cronenberg:
            return NSLocalizedString("Cronenberg", comment: "Cronenberg SpeciesType")
        case .unknown:
            return NSLocalizedString("Unknown", comment: "Unknown SpeciesType")
        }
    }
}
