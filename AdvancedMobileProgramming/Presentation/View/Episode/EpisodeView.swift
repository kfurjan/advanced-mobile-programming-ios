//
//  EpisodeView.swift
//  AdvancedMobileProgramming
//
//  Created by Ericsson on 08.08.2023..
//

import SwiftUI

struct EpisodeView: View {

    @ObservedObject var episodeViewModel = EpisodeViewModel()

    var body: some View {
        List(episodeViewModel.episodes, id: \.self) { episode in
            Text(episode.name)
                .onAppear {
                    episodeViewModel.onScrolledAtBottom(episode: episode)
                }
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView()
    }
}
