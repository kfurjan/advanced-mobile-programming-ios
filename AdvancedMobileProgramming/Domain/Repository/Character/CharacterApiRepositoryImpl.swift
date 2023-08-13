//
//  CharacterApiRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Alamofire
import Foundation

final class CharacterApiRepositoryImpl: ApiRepository {

    typealias T = CharacterApi
    typealias U = CharacterResult

    /// Generic method that fetches all data from REST API.
    ///
    /// - Parameter page:page of the REST API response.
    /// - Returns: ``CharacterApi`` object.
    func getAll(page: Int = 1) async throws -> CharacterApi {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(ApiEndpoints.character)?page=\(page)",
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CharacterApi.self) { response in
                switch response.result {
                case .success(let characterApiList):
                    continuation.resume(returning: characterApiList)
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
    /// - Returns: ``CharacterResult`` object.
    func getById(id: Int) async throws -> CharacterResult {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(ApiEndpoints.character)/\(id)",
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CharacterResult.self) { response in
                switch response.result {
                case .success(let character):
                    continuation.resume(returning: character)
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
    /// - Returns: ``CharacterResult`` object.
    func getByUri(uri: String) async throws -> CharacterResult {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                uri,
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CharacterResult.self) { response in
                switch response.result {
                case .success(let character):
                    continuation.resume(returning: character)
                case .failure:
                    continuation.resume(throwing: ApiError.unableToFetchData)
                }
            }
        }
    }
}
