//
//  EpisodeViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation
import RealmSwift

@MainActor
final class EpisodeViewModel: ObservableObject {

    private let _getEpisodeFromApiUseCase = GetEpisodeFromApiUseCase()
    private let _episodeDaoRepository = EpisodeDaoRepositoryImpl()

    @Published private(set) var episodes: [Episode] = []

    @UserDefault(UserDefaultStrings.episodePage, defaultValue: 1)
    private var page: Int

    init() {
        fetchAllEpisodes()
    }

    func fetchAllEpisodes() {
        Task {
            switch await _getEpisodeFromApiUseCase.getAllEpisodes(page: self.page) {
            case .success(let episodes):
                _episodeDaoRepository.writeAll(objects: episodes.map(EpisodeDao.toDaoObject))
                self.episodes = _episodeDaoRepository.readAll().map(EpisodeDao.toGeneralObject)
            case .failure(let apiError):
                print(apiError)  // TODO: show ApiError on the UI
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
