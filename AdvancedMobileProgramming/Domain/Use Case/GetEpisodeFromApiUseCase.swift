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
    /// - Returns: List of ``Episode`` objects if success, otherwise ``ApiError``.
    func getAllEpisodes() async -> Result<[Episode], ApiError> {
        do {
            return .success(try await _episodeApiRepository.getAll().results.map { episodeResult in
                Episode(
                    id: episodeResult.id,
                    name: episodeResult.name,
                    airDate: episodeResult.airDate,
                    episode: episodeResult.episode,
                    characters: episodeResult.characters
                )
            })
        } catch {
            return .failure(.unableToDetchData)
        }
    }
}
