//
//  BaseViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import SwiftUI

protocol BaseViewModel: ObservableObject {

    associatedtype Dao: DaoRepository
    associatedtype Paging: PagingSource

    var dao: Dao { get async }
    var paging: Paging { get async }

    /// Function which fetches data that will be shown on the UI.
    ///
    /// - Parameter loadType: ``LoadTypeEvent`` which defines which data to fetch.
    func fetchData(loadType: LoadTypeEvent) async

    /// Function that executes when user reaches end of the scrollable ``SwiftUI.List``.
    func onScrolledAtBottom() async

    /// Function that exectues when user refreshes ``SwiftUI.List`` with pull-down-to-refresh action.
    func onRefresh() async

    /// Function that exectues when user searches ``SwiftUI.List``.
    func onSearch() async
}
