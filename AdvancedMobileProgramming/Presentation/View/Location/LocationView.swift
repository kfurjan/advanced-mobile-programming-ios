//
//  LocationView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import SwiftUI

struct LocationItem: View {

    let location: Location

    private var locationStats: String {
        if location.dimension.isEmpty {
            return location.type
        } else if location.type.isEmpty {
            return location.dimension
        } else {
            return "\(location.dimension), \(location.type)"
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.headline)
                .bold()
            HStack {
                Text(locationStats)
                    .font(.subheadline)
            }
        }
    }
}

struct LocationView: View {

    @ObservedObject var viewModel = LocationViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.locations, id: \.self) { location in
                LocationItem(location: location)
                    .frame(height: 50)
                    .onAppear {
                        withAnimation {
                            if viewModel.locations.last == location {
                                viewModel.onScrolledAtBottom()
                            }
                        }
                    }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search locations...")
            .onChange(of: viewModel.searchText) { _ in
                withAnimation {
                    viewModel.onSearch()
                }
            }
            .refreshable {
                withAnimation {
                    viewModel.onRefresh()
                }
            }
            .navigationTitle("Locations")
        }
        .onAppear {
            viewModel.fetchData(loadType: .initial)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
