//
//  MockDIContainer.swift
//  MoveChallange
//
//  Created by Clinton on 23/02/2025.
//

@testable import MoveChallange
import Foundation
import Swinject

class MockAPIService: APIServiceProtocol {
    var baseURLString: String = ""
    

    var mockCharacterPageDTO: CharacterPageDTO!
    var shouldThrowError: Bool = false

    func fetchCharactersPage(for pageNumber: Int, search criteria: String) async throws -> CharacterPageDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        mockCharacterPageDTO = CharacterPageDTO(count: 10, next: "link", previous: nil, results: [])
        return mockCharacterPageDTO
    }

    func fetchFilmsPage(for pageNumber: Int, search criteria: String) async throws -> FilmPageDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return FilmPageDTO(count: 0, next: nil, previous: nil, results: [])
    }

    func fetchSpaceshipsDTOPage(for pageNumber: Int, search criteria: String) async throws -> SpaceshipPageDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return SpaceshipPageDTO(count: 0, next: nil, previous: nil, results: [])
    }

    func fetchCharacter(urlString: String) async throws -> CharacterDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return CharacterDTO(
            birth_year: "",
            eye_color: "",
            films: [],
            gender: "",
            hair_color: "",
            height: "",
            homeworld: "",
            name: "",
            created: "",
            edited: "",
            species: [],
            starships: [],
            url: "",
            vehicles: []
        )
    }

    func fetchFilm(urlString: String) async throws -> FilmDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return FilmDTO(
            characters: [],
            created: "",
            director: "",
            edited: "",
            episode_id: 0,
            opening_crawl: "",
            planets: [],
            producer: "",
            release_date: "",
            species: [],
            starships: [],
            title: "",
            url: "",
            vehicles: []
        )
    }

    func fetchSpaceship(urlString: String) async throws -> SpaceshipDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return SpaceshipDTO(
            MGLT: "",
            cargo_capacity: "",
            consumables: "",
            cost_in_credits: "",
            created: "",
            crew: "",
            edited: "",
            hyperdrive_rating: "",
            length: "",
            max_atmosphering_speed: "",
            model: "",
            name: "",
            passengers: "",
            films: [],
            pilots: [],
            starship_class: "",
            url: ""
        )
    }
}

class MockCharacterPageRepository: CharacterPageRepositoryProtocol {

    var mockCharacterPageDTO: CharacterPage!
    var shouldThrowError: Bool = false

    func fetchCharactersPage(for pageNumber: Int, search criteria: String) async throws -> MoveChallange.CharacterPage {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        let characterPage = CharacterPage(dto: CharacterPageDTO(count: 10, next: "link", previous: nil, results: []))
        return characterPage
    }
}

class MockFetchCharacterPageUseCase: FetchCharacterPageUseCaseProtocol {

    var mockCharacterPageDTO: CharacterPageDTO!
    var shouldThrowError: Bool = false
    

    func execute(for pageNumber: Int, search criteria: String) async throws -> MoveChallange.CharacterPage {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return CharacterPage(dto: CharacterPageDTO(count: 10, next: "link", previous: nil, results: []))
    }
}

class MockDIContainer {
//    static let shared = MockDIContainer()
    static var container: Container!

    static func setUp() {
        container = Container()
        container.register(APIServiceProtocol.self) { _ in MockAPIService() }
    }
//    private init() {
//        container = Container()
//
//        registerServices()
//    }

    private func registerServices() {

    }

    private func registerRepositories() {

    }

    private func registerUseCases() {

    }

    private func registerViewModels() {
        
    }
}
