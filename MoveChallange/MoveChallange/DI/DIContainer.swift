//
//  DIContainer.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Swinject

class DIContainer {
    static let shared = DIContainer()
    let container: Container


    private init() {
        container = Container()

        registerServices()
        registerRepositories()
        registerUseCases()
        registerViewModels()
        registerCoordinator()
    }

    private func registerServices() {
        container.register(APIServiceProtocol.self) { _ in APIService() }
    }

    private func registerRepositories() {
        container.register(CharacterPageRepositoryProtocol.self) { resolver in
            CharacterPageRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(FilmPageRepositoryProtocol.self) { resolver in
            FilmPageRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(SpaceshipPageRepositoryProtocol.self) { resolver in
            SpaceshipPageRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
    }

    private func registerUseCases() {
        container.register(FetchCharacterPageUseCaseProtocol.self) { resolver in
            FetchCharacterPageUseCase(repository: resolver.resolve(CharacterPageRepositoryProtocol.self)!)
        }
        container.register(FilterCharacterGenderUseCaseProtocol.self) { resolver in
            FilterCharacterGenderUseCase()
        }
        container.register(FetchFilmPageUseCaseProtocol.self) { resolver in
            FetchFilmPageUseCase(repository: resolver.resolve(FilmPageRepositoryProtocol.self)!)
        }
        container.register(FetchSpaceshipPageUseCaseProtocol.self) { resolver in
            FetchSpaceshipPageUseCase(repository: resolver.resolve(SpaceshipPageRepositoryProtocol.self)!)
        }
    }

    private func registerViewModels() {
        container.register(CharacterPageViewModel.self) { resolver in
            CharacterPageViewModel(
                fetchCharacterPageUseCase: resolver.resolve(FetchCharacterPageUseCaseProtocol.self)!,
                filterCharacterGenderUseCase: resolver.resolve(FilterCharacterGenderUseCaseProtocol.self)!
            )
        }
        container.register(FilmPageViewModel.self) { resolver in
            FilmPageViewModel(fetchFilmPageUseCase: resolver.resolve(FetchFilmPageUseCaseProtocol.self)!)
        }
        container.register(SpaceshipPageViewModel.self) { resolver in
            SpaceshipPageViewModel(fetchSpaceshipUseCase: resolver.resolve(FetchSpaceshipPageUseCaseProtocol.self)!)
        }
    }

    private func registerCoordinator() {
        container.register(CharacterCoordinator.self) { resolver in
            CharacterCoordinator(fetchCharacterPageUseCase: resolver.resolve(FetchCharacterPageUseCaseProtocol.self)!)
        }
        container.register(FilmCoordinator.self) { resolver in
            FilmCoordinator(fetchFilmPageUseCase: resolver.resolve(FetchFilmPageUseCaseProtocol.self)!)
        }
        container.register(SpaceshipCoordinator.self) { resolver in
            SpaceshipCoordinator(fetchSpaceshipPageUseCase: resolver.resolve(FetchSpaceshipPageUseCaseProtocol.self)!)
        }
        container.register(FavoriteCoordinator.self) { resolver in
            FavoriteCoordinator()
        }
        container.register(AppCoordinator.self) { resolver in
            AppCoordinator(
                characterCoordinator: resolver.resolve(CharacterCoordinator.self)!,
                filmCoordinator: resolver.resolve(FilmCoordinator.self)!,
                spaceshipCoordinator: resolver.resolve(SpaceshipCoordinator.self)!,
                favoriteCoordinator: resolver.resolve(FavoriteCoordinator.self)!
            )
        }
    }

    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(T.self)!
    }
}
