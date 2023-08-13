//
//  LocationApiRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Alamofire
import Foundation

final class LocationApiRepositoryImpl: ApiRepository {

    typealias T = LocationApi
    typealias U = LocationResult

    /// Generic method that fetches all data from REST API.
    ///
    /// - Parameter page:page of the REST API response.
    /// - Returns: ``LocationApi`` object.
    func getAll(page: Int = 1) async throws -> LocationApi {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(ApiEndpoints.location)?page=\(page)",
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LocationApi.self) { response in
                switch response.result {
                case .success(let locationApiList):
                    continuation.resume(returning: locationApiList)
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
    /// - Returns: ``LocationResult`` object.
    func getById(id: Int) async throws -> LocationResult {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(ApiEndpoints.location)/\(id)",
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LocationResult.self) { response in
                switch response.result {
                case .success(let location):
                    continuation.resume(returning: location)
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
    /// - Returns: ``LocationResult`` object.
    func getByUri(uri: String) async throws -> LocationResult {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                uri,
                method: .get,
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LocationResult.self) { response in
                switch response.result {
                case .success(let location):
                    continuation.resume(returning: location)
                case .failure:
                    continuation.resume(throwing: ApiError.unableToFetchData)
                }
            }
        }
    }

}
