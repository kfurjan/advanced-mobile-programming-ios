//
//  LocationView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import SwiftUI

struct LocationDetailView: View {

    let location: LocationDetail

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
        VStack {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Location")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                HStack {
                    Text(location.name)
                        .font(.body)
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding([.top])

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Information")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                HStack {
                    Text(locationStats)
                        .font(.body)
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding([.top])

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Characters")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.leading, .trailing])

                List(location.residents, id: \.self) { character in
                    CharacterItem(character: character)
                        .frame(height: 50)
                }
                .listStyle(PlainListStyle())
            }
            .padding([.top])
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

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
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.locations, id: \.self) { location in
                        NavigationLink(destination: LocationDetailView(location: viewModel.onItemClicked(id: location.id))) {
                            LocationItem(location: location)
                                .frame(height: 50)
                                .onAppear {
                                    if viewModel.locations.last == location {
                                        viewModel.onScrolledAtBottom()
                                    }
                                }
                        }

                    }
                    .onMove { from, to in
                        viewModel.onMove(fromOffsets: from, toOffset: to)
                    }
                    .onDelete { index in
                        viewModel.onDelete(at: index)
                    }
                }
                .refreshable {
                    viewModel.onRefresh()
                }
            }
            .toolbar {
                EditButton()
            }
            .navigationTitle("Locations")
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search locations...")
        .onChange(of: viewModel.searchText) { _ in
            viewModel.onSearch()
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
