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

    private let _paging = EpisodePagingSource()
    private let _dao = EpisodeDaoRepositoryImpl()

    @Published var searchText: String = ""
    @Published private(set) var episodes: [Episode] = []

    @UserDefault(UserDefaultStrings.episodePage, defaultValue: 1)
    private var page: Int

    init() {
        fetchEpisodes(loadType: .initial)
    }

    func fetchEpisodes(loadType: LoadType) {
        Task {
            switch await _paging.load(page: self.page, loadType: loadType) {
            case .success(let episodes):
                self.episodes = episodes
            case .failure(let error):
                print(error)  // TODO: show Error on the UI
            }
        }
    }

    func onScrolledAtBottom(episode: Episode) {
        if self.episodes.last == episode
            && self.episodes.last?.nextPageExists ?? false
            && searchText.isEmpty {
            self.page += 1
            self.fetchEpisodes(loadType: .append)
        }
    }

    func onRefresh() {
        self.page = 1
        self.searchText = ""
        self.fetchEpisodes(loadType: .refresh)
    }

    func onSearch() {
        if self.searchText.isEmpty {
            self.episodes = _dao.readAll().map(EpisodeDao.toGeneralObject)
        } else {
            self.episodes = _dao.read(where: searchText).map(EpisodeDao.toGeneralObject)
        }
    }
}
