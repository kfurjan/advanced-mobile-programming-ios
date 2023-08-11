//
//  EpisodeView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import SwiftUI

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
            List(viewModel.episodes, id: \.self) { episode in
                EpisodeItem(episode: episode)
                    .frame(height: 50)
                    .onAppear {
                        withAnimation {
                            viewModel.onScrolledAtBottom(episode: episode)
                        }
                    }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search episodes...")
            .onChange(of: viewModel.searchText) { _ in
                viewModel.onSearch()
            }
            .refreshable {
                withAnimation {
                    viewModel.onRefresh()
                }
            }
            .navigationTitle("Episodes")
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView()
    }
}
