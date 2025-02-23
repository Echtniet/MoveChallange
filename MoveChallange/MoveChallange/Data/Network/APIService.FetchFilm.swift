//
//  APIService..FetchFilm.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

extension APIService {
    func fetchFilm(urlString: String) async throws -> FilmDTO {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(FilmDTO.self, from: data)
    }
}
