//
//  LocationViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation

@MainActor
final class LocationViewModel: BaseViewModel {

    typealias Dao = LocationDaoRepositoryImpl
    typealias Paging = LocationPagingSource

    var dao: Dao = LocationDaoRepositoryImpl()
    var paging: Paging = LocationPagingSource()

    @Published var searchText: String = ""
    @Published private(set) var locations: [Location] = []

    @UserDefault(UserDefaultStrings.locationPage, defaultValue: 1)
    private var page: Int

    /// Function which fetches data that will be shown on the UI.
    ///
    /// - Parameter loadType: ``LoadTypeEvent`` which defines which data to fetch.
    func fetchData(loadType: LoadTypeEvent) {
        Task {
            switch await paging.load(page: self.page, loadType: loadType) {
            case .success(let locations):
                self.locations = locations
            case .failure(let error):
                print(error)  // TODO: show Error on the UI
            }
        }
    }

    /// Function that executes when user reaches end of the scrollable ``SwiftUI.List``.
    func onScrolledAtBottom() {
        if self.locations.last?.nextPageExists ?? false && searchText.isEmpty {
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
            self.locations = dao.readAll().map(LocationDao.toGeneralObject)
        } else {
            self.locations = dao.read(where: searchText).map(LocationDao.toGeneralObject)
        }
    }

    /// Function that exectues when user interacts with item in ``SwiftUI.List``.
    /// - Parameter id: id of the object clicked
    /// - Returns: ``LocationDetail`` object.
    func onItemClicked(id: Int) -> LocationDetail {
        dao.read(where: id)
    }

    /// Function that exectues when user moves an item within ``SwiftUI.List``.
    /// - Parameters:
    ///   - source: Initial index of the item.
    ///   - destination: Destination index of the item.
    func onMove(fromOffsets source: IndexSet, toOffset destination: Int) {
        self.locations.move(fromOffsets: source, toOffset: destination)
    }

    /// Function that exectues when user deletes an item within ``SwiftUI.List``.
    /// - Parameter offsets: index of the item
    func onDelete(at offsets: IndexSet) {
        self.locations.remove(atOffsets: offsets)
    }
}
