//
//  CharacterView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterItem: View {

    let character: Character

    private var characterStats: String {
        "\(character.species), \(character.status)"
    }

    var body: some View {
        HStack(alignment: .center) {
            WebImage(url: URL(string: character.image))
                .resizable()
                .placeholder(
                    Image(systemName: "person.fill")
                )
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .frame(width: 50, height: 50, alignment: .center)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .bold()
                HStack {
                    Text(characterStats)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct CharacterView: View {

    @ObservedObject var viewModel = CharacterViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                FilterRowView<SpeciesType>(block: { type in
                    withAnimation {
                        viewModel.onFilter(type: type)
                    }
                    viewModel.selectedSpeciesType = type
                })
                .padding([.leading, .trailing])

                List(viewModel.characters, id: \.self) { character in
                    CharacterItem(character: character)
                        .frame(height: 50)
                        .onAppear {
                            if viewModel.characters.last == character {
                                viewModel.onScrolledAtBottom()
                            }
                        }
                }
                .refreshable {
                    viewModel.onRefresh()
                }
                .padding([.bottom], 1)
            }
            .navigationTitle("Characters")
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search characters...")
        .onChange(of: viewModel.searchText) { _ in
            viewModel.onSearch()
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}