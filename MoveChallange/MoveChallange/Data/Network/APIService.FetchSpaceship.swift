//
//  APIService.FetchSpaceship.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

extension APIService {
    func fetchSpaceship(urlString: String) async throws -> SpaceshipDTO {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(SpaceshipDTO.self, from: data)
    }
}
