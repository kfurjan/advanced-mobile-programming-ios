//
//  EpisodeViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation

@MainActor
final class EpisodeViewModel: ObservableObject {

    private let _getEpisodeFromApiUseCase = GetEpisodeFromApiUseCase()

    var page: Int = 1

    @Published private(set) var episodes: [Episode] = []

    init() {
        fetchAllEpisodes()
    }

    func fetchAllEpisodes() {
        Task {
            switch await _getEpisodeFromApiUseCase.getAllEpisodes(page: self.page) {
            case .success(let episodes):
                self.episodes.append(contentsOf: episodes)
            case .failure(let apiError):
                print(apiError)
            }
        }
    }

    func onScrolledAtBottom(episode: Episode) {
        if self.episodes.last == episode && self.episodes.last?.nextPageExists ?? false {
            self.page += 1
            self.fetchAllEpisodes()
        }
    }
}
