//
//  ButtonStyles.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import SwiftUI

struct AuthenticationButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(Color(UIColors.onSecondaryColor))
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(UIColors.secondaryColor))
      .cornerRadius(12)
      .padding()
  }
}

struct FilterButtonStyle: ButtonStyle {

    let isSelected: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(
        isSelected ? Color(UIColors.onSecondaryColor) : Color(UIColors.onSurfaceColor)
      )
      .padding()
      .frame(maxWidth: .infinity, maxHeight: 30)
      .background(
        isSelected ? Color(UIColors.secondaryColor) : Color(UIColors.surfaceColor)
      )
      .cornerRadius(24)
      .overlay(
        RoundedRectangle(cornerRadius: 24)
            .stroke(isSelected ? Color(UIColors.surfaceColor) : Color(UIColors.secondaryColor), lineWidth: 0.3)
      )
  }
}
