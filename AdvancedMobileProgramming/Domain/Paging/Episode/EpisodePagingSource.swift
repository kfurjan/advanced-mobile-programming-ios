//
//  EpisodePagingSource.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 09.08.2023.
//

import Foundation

final class EpisodePagingSource: PagingSource {

    typealias Repo = EpisodeApiRepositoryImpl
    typealias DAO = EpisodeDaoRepositoryImpl
    typealias Response = Episode
    typealias CustomError = ApiError

    var dao: DAO = EpisodeDaoRepositoryImpl()
    var restApi: Repo = EpisodeApiRepositoryImpl()

    /// Main function which will load data directly from the database (if data exists), or load data from REST API,
    /// and save it to the database.
    ///
    /// - Parameters:
    ///   - page: REST API page number
    ///   - loadType: whether it is `initial`, `refresh` or `append` load event.
    /// - Returns: Returns list of ``Episode`` objects, ``ApiError`` otherwise.
    func load(page: Int, loadType: LoadType) async -> Result<[Response], CustomError> {
        switch loadType {
        case .initial:
            do {
                return .success(try await onInitialLoad(page: page))
            } catch {
                return .failure(.customError(message: "Unable to load data", comment: "ApiError.unableToLoadData"))
            }
        case .refresh:
            do {
                return .success(try await onRefresh(page: page))
            } catch {
                return .failure(.customError(message: "Could not refresh data", comment: "ApiError.couldNotRefresh"))
            }
        case .append:
            do {
                return .success(try await onAppend(page: page))
            } catch {
                return .failure(.customError(message: "Could not append data", comment: "ApiError.couldNotAppend"))
            }
        }
    }

    private func onInitialLoad(page: Int) async throws -> [Response] {
        let daoData = dao.readAll()

        if daoData.count == 0 {
            let data = try await restApi.getAll(page: page)
            dao.writeAll(objects: data.results.map { episodeResult in
                EpisodeDao.toDaoObject(episode: episodeResult, info: data.info)
            })
            return dao.readAll().map(EpisodeDao.toGeneralObject)
        } else {
            return daoData.map(EpisodeDao.toGeneralObject)
        }
    }

    private func onAppend(page: Int) async throws -> [Response] {
        let data = try await restApi.getAll(page: page)
        dao.writeAll(objects: data.results.map { episodeResult in
            EpisodeDao.toDaoObject(episode: episodeResult, info: data.info)
        })
        return dao.readAll().map(EpisodeDao.toGeneralObject)
    }

    private func onRefresh(page: Int) async throws -> [Response] {
        dao.deleteAll()

        let data = try await restApi.getAll(page: page)
        dao.writeAll(objects: data.results.map { episodeResult in
            EpisodeDao.toDaoObject(episode: episodeResult, info: data.info)
        })

        return dao.readAll().map(EpisodeDao.toGeneralObject)
    }
}
