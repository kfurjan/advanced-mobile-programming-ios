//
//  EpisodeView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct EpisodeDetailView: View {

    let episode: EpisodeDetail

    private var episodeStats: String {
        "\(episode.episode), \(episode.airDate)"
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Episode name")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                HStack {
                    Text(episode.name)
                        .font(.body)
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding([.top])

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Air date")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                HStack {
                    Text(episodeStats)
                        .font(.body)
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding([.top])

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Characters")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                List(episode.characters, id: \.self) { character in
                    CharacterItem(character: character)
                        .frame(height: 50)
                }
                .listStyle(PlainListStyle())
            }
            .padding([.top])
        }
        .navigationTitle(episode.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EpisodeItem: View {

    let episode: Episode

    private var episodeStats: String {
        "\(episode.episode), \(episode.airDate)"
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.name)
                .font(.headline)
                .bold()
            HStack {
                Text(episodeStats)
                    .font(.subheadline)
            }
        }
    }
}

struct EpisodeView: View {

    @ObservedObject var viewModel = EpisodeViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.episodes, id: \.self) { episode in
                        NavigationLink(
                            destination: EpisodeDetailView(episode: viewModel.onItemClicked(id: episode.id))
                        ) {
                            EpisodeItem(episode: episode)
                                .frame(height: 50)
                                .onAppear {
                                    if viewModel.episodes.last == episode {
                                        viewModel.onScrolledAtBottom()
                                    }
                                }
                        }
                    }
                    .onMove { from, to in
                        viewModel.onMove(fromOffsets: from, toOffset: to)
                    }
                    .onDelete { index in
                        viewModel.onDelete(at: index)
                    }
                }
                .refreshable {
                    viewModel.onRefresh()
                }
            }
            .toolbar {
                EditButton()
            }
            .navigationTitle("Episodes")
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search episodes...")
        .onChange(of: viewModel.searchText) { _ in
            viewModel.onSearch()
        }
        .onAppear {
            viewModel.fetchData(loadType: .initial)
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView()
    }
}
