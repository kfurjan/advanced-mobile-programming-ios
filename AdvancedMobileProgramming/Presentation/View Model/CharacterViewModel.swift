//
//  CharacterViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation

@MainActor
final class CharacterViewModel: BaseViewModel {

    typealias Dao = CharacterDaoRepositoryImpl
    typealias Paging = CharacterPagingSource

    var dao: Dao = CharacterDaoRepositoryImpl()
    var paging: Paging = CharacterPagingSource()

    @Published var searchText: String = ""
    @Published var selectedSpeciesType: SpeciesType = .all
    @Published private(set) var characters: [Character] = []

    @UserDefault(UserDefaultStrings.characterPage, defaultValue: 1)
    private var page: Int

    /// Function which fetches data that will be shown on the UI.
    ///
    /// - Parameter loadType: ``LoadTypeEvent`` which defines which data to fetch.
    func fetchData(loadType: LoadTypeEvent) {
        Task {
            switch await paging.load(page: self.page, loadType: loadType) {
            case .success(let characters):
                self.characters = characters
            case .failure(let error):
                print(error)  // TODO: show Error on the UI
            }
        }
    }

    /// Function that executes when user reaches end of the scrollable ``SwiftUI.List``.
    func onScrolledAtBottom() {
        if self.characters.last?.nextPageExists ?? false && searchText.isEmpty && selectedSpeciesType == .all {
            self.page += 1
            self.fetchData(loadType: .append)
        }
    }

    /// Function that exectues when user refreshes ``SwiftUI.List`` with pull-down-to-refresh action.
    func onRefresh() {
        self.page = 1
        self.searchText = ""
        self.selectedSpeciesType = .all
        self.fetchData(loadType: .refresh)
    }

    /// Function that exectues when user searches ``SwiftUI.List``.
    func onSearch() {
        if self.searchText.isEmpty {
            self.characters = dao.readAll().map(CharacterDao.toGeneralObject)
        } else {
            self.characters = dao.read(where: searchText).map(CharacterDao.toGeneralObject)
        }
    }

    func onFilter(type: SpeciesType) {
        guard self.searchText.isEmpty else {
            return
        }

        if type == .all {
            self.characters = dao.readAll().map(CharacterDao.toGeneralObject)
        } else {
            self.characters = dao.readSpeacies(where: type.rawValue).map(CharacterDao.toGeneralObject)
        }
    }

    /// Function that exectues when user interacts with item in ``SwiftUI.List``.
    /// - Parameter id: id of the object clicked
    /// - Returns: ``CharacterDetail`` object.
    func onItemClicked(id: Int) -> CharacterDetail {
        dao.read(where: id)
    }
}
