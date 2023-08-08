//
//  GetEpisodeFromApiUseCase.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation

final class GetEpisodeFromApiUseCase {

    private let _episodeApiRepository = EpisodeApiRepositoryImpl()

    /// Fetches all episodes using ``EpisodeApiRepositoryImpl`` and ``EpisodeApi``
    /// and maps them to the list of ``Episode`` objects.
    ///
    /// - Parameter page:page of the REST API response.
    /// - Returns: List of ``Episode`` objects if success, otherwise ``ApiError``.
    func getAllEpisodes(page: Int = 1) async -> Result<[Episode], ApiError> {
        do {
            let data = try await _episodeApiRepository.getAll(page: page)
            return .success(data.results.map { episodeResult in
                Episode(
                    id: episodeResult.id,
                    name: episodeResult.name,
                    airDate: episodeResult.airDate,
                    episode: episodeResult.episode,
                    characters: episodeResult.characters,
                    nextPageExists: data.info.next != nil ? true : false
                )
            })
        } catch {
            return .failure(.unableToDetchData)
        }
    }
}
