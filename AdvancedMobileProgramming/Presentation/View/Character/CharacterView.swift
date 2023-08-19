//
//  CharacterView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailView: View {

    let character: CharacterDetail

    private var characterStats: String {
        "\(character.species), \(character.status)"
    }

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                WebImage(url: URL(string: character.image))
                    .resizable()
                    .placeholder(
                        Image(systemName: "person.fill")
                    )
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(width: 175, height: 200, alignment: .center)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Name")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                HStack {
                    Text(character.name)
                        .font(.body)
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding([.top])

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Information")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                HStack {
                    Text(characterStats)
                        .font(.body)
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding([.top])

            if !character.type.isEmpty {
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("Type")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding([.leading, .trailing])

                    HStack {
                        Text(character.type)
                            .font(.body)
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                }
                .padding([.top])
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Episodes")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                List(character.episode, id: \.self) { episode in
                    EpisodeItem(episode: episode)
                        .frame(height: 50)
                }
                .listStyle(PlainListStyle())
            }
            .padding([.top])
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

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
                    NavigationLink(
                        destination: CharacterDetailView(character: viewModel.onItemClicked(id: character.id))
                    ) {
                        CharacterItem(character: character)
                            .frame(height: 50)
                            .onAppear {
                                if viewModel.characters.last == character {
                                    viewModel.onScrolledAtBottom()
                                }
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
        .onAppear {
            viewModel.fetchData(loadType: .initial)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
