//
//  APIService.FetchCharacterPage.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

extension APIService {
    func fetchCharactersPage(for pageNumber: Int) async throws -> CharacterPageDTO {
        let urlString = "\(baseURLString)/people/?page=\(pageNumber)&format=json"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(CharacterPageDTO.self, from: data)
    }
}
