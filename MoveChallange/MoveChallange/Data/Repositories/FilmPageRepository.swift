//
//  FilmPageRepository.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol FilmPageRepositoryProtocol {
    func fetchFilmsPage(for pageNumber: Int, search criteria: String) async throws -> FilmPage
}

class FilmPageRepository: FilmPageRepositoryProtocol {

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchFilmsPage(for pageNumber: Int, search criteria: String = "") async throws -> FilmPage {
        let filmPageDTO = try await apiService.fetchFilmsPage(for: pageNumber, search: criteria)
        return FilmPage(dto: filmPageDTO)
    }

}
