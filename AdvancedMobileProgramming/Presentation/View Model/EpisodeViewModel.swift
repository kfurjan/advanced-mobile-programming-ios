//
//  EpisodeViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation
import RealmSwift

@MainActor
final class EpisodeViewModel: BaseViewModel {

    typealias Dao = EpisodeDaoRepositoryImpl
    typealias Paging = EpisodePagingSource

    var dao: Dao = EpisodeDaoRepositoryImpl()
    var paging: Paging = EpisodePagingSource()

    @Published var searchText: String = ""
    @Published private(set) var episodes: [Episode] = []

    @UserDefault(UserDefaultStrings.episodePage, defaultValue: 1)
    private var page: Int

    /// Function which fetches data that will be shown on the UI.
    ///
    /// - Parameter loadType: ``LoadTypeEvent`` which defines which data to fetch.
    func fetchData(loadType: LoadTypeEvent) {
        Task {
            switch await paging.load(page: self.page, loadType: loadType) {
            case .success(let episodes):
                self.episodes = episodes
            case .failure(let error):
                print(error)  // TODO: show Error on the UI
            }
        }
    }

    /// Function that executes when user reaches end of the scrollable ``SwiftUI.List``.
    func onScrolledAtBottom() {
        if self.episodes.last?.nextPageExists ?? false && searchText.isEmpty {
            self.page += 1
            self.fetchData(loadType: .append)
        }
    }

    /// Function that exectues when user refreshes ``SwiftUI.List`` with pull-down-to-refresh action.
    func onRefresh() {
        self.page = 1
        self.searchText = ""
        self.fetchData(loadType: .refresh)
    }

    /// Function that exectues when user searches ``SwiftUI.List``.
    func onSearch() {
        if self.searchText.isEmpty {
            self.episodes = dao.readAll().map(EpisodeDao.toGeneralObject)
        } else {
            self.episodes = dao.read(where: searchText).map(EpisodeDao.toGeneralObject)
        }
    }

    /// Function that exectues when user interacts with item in ``SwiftUI.List``.
    /// - Parameter id: id of the object clicked
    /// - Returns: ``EpisodeDetail`` object.
    func onItemClicked(id: Int) -> EpisodeDetail {
        dao.read(where: id)
    }
}
