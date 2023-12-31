//
//  EpisodeApiRepository.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Alamofire
import Foundation

final class EpisodeApiRepositoryImpl: ApiRepository {

    typealias T = EpisodeApi
    typealias U = EpisodeResult

    /// Generic method that fetches all data from REST API.
    ///
    /// - Parameter page:page of the REST API response.
    /// - Returns: ``EpisodeApi`` object.
    func getAll(page: Int = 1) async throws -> EpisodeApi {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(ApiEndpoints.episode)?page=\(page)",
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: EpisodeApi.self) { response in
                switch response.result {
                case .success(let episodeApiList):
                    continuation.resume(returning: episodeApiList)
                case .failure:
                    continuation.resume(throwing: ApiError.unableToFetchData)
                }
            }
        }
    }

    /// Generic method that fetches single object from REST API
    /// based on its ID.
    ///
    /// - Parameter id:ID of the REST API object.
    /// - Returns: ``EpisodeResult`` object.
    func getById(id: Int) async throws -> EpisodeResult {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(ApiEndpoints.episode)/\(id)",
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: EpisodeResult.self) { response in
                switch response.result {
                case .success(let episode):
                    continuation.resume(returning: episode)
                case .failure:
                    continuation.resume(throwing: ApiError.unableToFetchData)
                }
            }
        }
    }

    /// Generic method that fetches single object from REST API
    /// based on its URI.
    ///
    /// - Parameter id:URI of the REST API object.
    /// - Returns: ``EpisodeResult`` object.
    func getByUri(uri: String) async throws -> EpisodeResult {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                uri,
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: EpisodeResult.self) { response in
                switch response.result {
                case .success(let episode):
                    continuation.resume(returning: episode)
                case .failure:
                    continuation.resume(throwing: ApiError.unableToFetchData)
                }
            }
        }
    }
}
