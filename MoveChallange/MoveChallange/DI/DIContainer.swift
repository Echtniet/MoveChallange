//
//  DIContainer.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Swinject

@MainActor
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
        container.register(CharacterRepositoryProtocol.self) { resolver in
            CharacterRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(FilmPageRepositoryProtocol.self) { resolver in
            FilmPageRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(FilmRepositoryProtocol.self) { resolver in
            FilmRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(SpaceshipPageRepositoryProtocol.self) { resolver in
            SpaceshipPageRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(SpaceshipRepositoryProtocol.self) { resolver in
            SpaceshipRepository(apiService: resolver.resolve(APIServiceProtocol.self)!)
        }
        container.register(FavoriteStorageProtocol.self) {resolver in
            FavoriteStorage()
        }
    }

    private func registerUseCases() {
        container.register(FetchCharacterPageUseCaseProtocol.self) { resolver in
            FetchCharacterPageUseCase(repository: resolver.resolve(CharacterPageRepositoryProtocol.self)!)
        }
        container.register(FilterCharacterGenderUseCaseProtocol.self) { resolver in
            FilterCharacterGenderUseCase()
        }
        container.register(FetchCharacterByIdUseCaseProtocol.self) { resolver in
            FetchCharacterByIdUseCase(repository: resolver.resolve(CharacterRepositoryProtocol.self)!)
        }
        container.register(FetchFilmPageUseCaseProtocol.self) { resolver in
            FetchFilmPageUseCase(repository: resolver.resolve(FilmPageRepositoryProtocol.self)!)
        }
        container.register(FetchFilmByIdUseCaseProtocol.self) { resolver in
            FetchFilmByIdUseCase(repository: resolver.resolve(FilmRepositoryProtocol.self)!)
        }
        container.register(FetchSpaceshipPageUseCaseProtocol.self) { resolver in
            FetchSpaceshipPageUseCase(repository: resolver.resolve(SpaceshipPageRepositoryProtocol.self)!)
        }
        container.register(FetchSpaceshipByIdUseCaseProtocol.self) { resolver in
            FetchSpaceshipByIdUseCase(repository: resolver.resolve(SpaceshipRepositoryProtocol.self)!)
        }
        container.register(FavoriteCharacterUseCaseProtocol.self) { resolver in
            FavoriteCharacterUseCase(repository: resolver.resolve(FavoriteStorageProtocol.self)!)
        }
        container.register(FavoriteFilmUseCaseProtocol.self) { resolver in
            FavoriteFilmUseCase(repository: resolver.resolve(FavoriteStorageProtocol.self)!)
        }
        container.register(FavoriteSpaceshipUseCaseProtocol.self) { resolver in
            FavoriteSpaceshipUseCase(repository: resolver.resolve(FavoriteStorageProtocol.self)!)
        }
    }

    private func registerViewModels() {
        container.register(CharacterPageViewModel.self) { resolver in
            CharacterPageViewModel(
                fetchCharacterPageUseCase: resolver.resolve(FetchCharacterPageUseCaseProtocol.self)!,
                filterCharacterGenderUseCase: resolver.resolve(FilterCharacterGenderUseCaseProtocol.self)!
            )
        }
        container.register(CharacterDetailViewModel.self) { resolver in
            CharacterDetailViewModel(
                fetchSpaceshipByIdUseCase: resolver.resolve(FetchSpaceshipByIdUseCaseProtocol.self)!,
                fetchFilmByIdUseCase: resolver.resolve(FetchFilmByIdUseCaseProtocol.self)!,
                favoriteCharacterUseCase: resolver.resolve(FavoriteCharacterUseCaseProtocol.self)!
            )
        }
        container.register(FilmPageViewModel.self) { resolver in
            FilmPageViewModel(fetchFilmPageUseCase: resolver.resolve(FetchFilmPageUseCaseProtocol.self)!)
        }
        container.register(FilmDetailViewModel.self) { resolver in
            FilmDetailViewModel(
                fetchSpaceshipByIdUseCase: resolver.resolve(FetchSpaceshipByIdUseCaseProtocol.self)!,
                fetchCharacterByIdUseCase: resolver.resolve(FetchCharacterByIdUseCaseProtocol.self)!,
                favortieFilmUseCase: resolver.resolve(FavoriteFilmUseCaseProtocol.self)!
            )
        }
        container.register(SpaceshipPageViewModel.self) { resolver in
            SpaceshipPageViewModel(fetchSpaceshipUseCase: resolver.resolve(FetchSpaceshipPageUseCaseProtocol.self)!)
        }
        container.register(SpaceshipDetailViewModel.self) { resolver in
            SpaceshipDetailViewModel(
                fetchFilmByIdUseCase: resolver.resolve(FetchFilmByIdUseCaseProtocol.self)!,
                favoriteSpaceshipUseCase: resolver.resolve(FavoriteSpaceshipUseCaseProtocol.self)!
            )
        }
        container.register(FavoritesPageViewModel.self) { resolver in
            FavoritesPageViewModel(
                favoriteCharacterUseCase: resolver.resolve(FavoriteCharacterUseCaseProtocol.self)!,
                favoriteFilmUseCase: resolver.resolve(FavoriteFilmUseCaseProtocol.self)!,
                favoriteSpaceShipUseCase: resolver.resolve(FavoriteSpaceshipUseCaseProtocol.self)!
            )
        }
    }

    private func registerCoordinator() {
        container.register(CharacterCoordinator.self) { resolver in
            CharacterCoordinator(fetchCharacterPageUseCase: resolver.resolve(FetchCharacterPageUseCaseProtocol.self)!)
        }
        .inObjectScope(.container)
        container.register(FilmCoordinator.self) { resolver in
            FilmCoordinator(fetchFilmPageUseCase: resolver.resolve(FetchFilmPageUseCaseProtocol.self)!)
        }
        .inObjectScope(.container)
        container.register(SpaceshipCoordinator.self) { resolver in
            SpaceshipCoordinator(fetchSpaceshipPageUseCase: resolver.resolve(FetchSpaceshipPageUseCaseProtocol.self)!)
        }
        .inObjectScope(.container)
        container.register(FavoriteCoordinator.self) { resolver in
            FavoriteCoordinator()
        }
        .inObjectScope(.container)
        container.register(AppCoordinator.self) { resolver in
            AppCoordinator(
                characterCoordinator: resolver.resolve(CharacterCoordinator.self)!,
                filmCoordinator: resolver.resolve(FilmCoordinator.self)!,
                spaceshipCoordinator: resolver.resolve(SpaceshipCoordinator.self)!,
                favoriteCoordinator: resolver.resolve(FavoriteCoordinator.self)!
            )
        }
        .inObjectScope(.container)
    }

    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(T.self)!
    }
}
