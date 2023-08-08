//
//  Localizable.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 01.08.2023.
//

/// Protocol used to provide localization functionalities to structs,
/// classes and enums by using computed property `localizedDescription`.
///
protocol Localizable {
    var localizedDescription: String { get }
}
