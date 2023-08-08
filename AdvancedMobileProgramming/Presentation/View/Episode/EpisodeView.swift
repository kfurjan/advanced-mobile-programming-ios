//
//  EpisodeView.swift
//  AdvancedMobileProgramming
//
//  Created by Ericsson on 08.08.2023..
//

import SwiftUI

struct EpisodeView: View {

    @ObservedObject var episodeViewModel = EpisodeViewModel()

    var body: some View {
        Text("EpisodeView!")
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView()
    }
}
