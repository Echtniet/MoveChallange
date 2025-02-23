//
//  APIService.FetchFilmPage.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

extension APIService {
    func fetchFilmsPage(for pageNumber: Int, search criteria: String = "") async throws -> FilmPageDTO {
        let urlString = "\(baseURLString)/films/?page=\(pageNumber)&format=json&search=\(criteria)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(FilmPageDTO.self, from: data)
    }
}
