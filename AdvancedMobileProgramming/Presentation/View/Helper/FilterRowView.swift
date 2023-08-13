//
//  FilterRowView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import SwiftUI

struct FilterRowView<T>: View
where T: RawRepresentable, T: Localizable, T: CaseIterable, T: Identifiable, T.AllCases == [T], T.RawValue == String {

    let block: (T) -> Void
    @State private var selectedFilter: T = T.allCases[0]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(T.allCases) { filter in
                    Button(action: {
                        withAnimation(Animation.spring().speed(1.5)) {
                            selectedFilter = filter
                        }
                        block(filter)
                    }) {
                        Text(filter.localizedDescription.capitalized)
                            .font(.subheadline)
                    }
                    .buttonStyle(FilterButtonStyle(isSelected: selectedFilter == filter))
                }
            }
        }
        .frame(height: 40)
    }
}

struct FilterRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilterRowView<SpeciesType>(block: { _ in })
                .previewLayout(.sizeThatFits)

            FilterRowView<SpeciesType>(block: { _ in })
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        .environment(\.locale, .init(identifier: "en"))

        Group {
            FilterRowView<SpeciesType>(block: { _ in })
                .previewLayout(.sizeThatFits)

            FilterRowView<SpeciesType>(block: { _ in })
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        .environment(\.locale, .init(identifier: "hr"))
    }
}
