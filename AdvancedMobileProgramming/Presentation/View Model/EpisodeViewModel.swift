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

    init() {
        fetchAllEpisodes()
    }

    func fetchAllEpisodes() {
        Task {
            switch await _getEpisodeFromApiUseCase.getAllEpisodes() {
            case .success(let episodes):
                print(episodes)
            case .failure(let apiError):
                print(apiError)
            }
        }
    }
}
