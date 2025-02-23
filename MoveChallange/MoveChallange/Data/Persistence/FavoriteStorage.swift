//
//  CharacterStorage.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation
import SwiftData

@MainActor
protocol FavoriteStorageProtocol {
    func saveFavorite(character: StarCharacter)
    func removeFavorite(character: StarCharacterDataModel)
    func getFavoriteCharacters() -> [StarCharacterDataModel]
    func saveFavorite(film: Film)
    func removeFavorite(film: FilmDataModel)
    func getFavoriteFilms() -> [FilmDataModel]
    func saveFavorite(spaceship: Spaceship)
    func removeFavorite(spaceship: SpaceshipDataModel)
    func getFavoriteSpaceships() -> [SpaceshipDataModel]
}

@MainActor
class FavoriteStorage: FavoriteStorageProtocol {
    private let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: StarCharacterDataModel.self, FilmDataModel.self, SpaceshipDataModel.self)
        } catch {

            fatalError("Failed to initialize SwiftData: \(error)")
        }
    }

    var context: ModelContext {
        modelContainer.mainContext
    }

    func saveFavorite(character: StarCharacter) {
        context.insert(StarCharacterDataModel(model: character))
        saveContext()
    }

    func removeFavorite(character: StarCharacterDataModel) {
        let id = character.id.uuidString
        let predicate = #Predicate<StarCharacterDataModel> { $0.id.uuidString == id }
        if let existing = try? context.fetch(FetchDescriptor(predicate: predicate)).first {
            context.delete(existing)
            saveContext()
        }
    }

    func getFavoriteCharacters() -> [StarCharacterDataModel] {
        let descriptor = FetchDescriptor<StarCharacterDataModel>()
        return (try? context.fetch(descriptor)) ?? []
    }

    func saveFavorite(film: Film) {
        context.insert(FilmDataModel(model: film))
        saveContext()
    }

    func removeFavorite(film: FilmDataModel) {
        let id = film.id.uuidString
        let predicate = #Predicate<FilmDataModel> { $0.id.uuidString == id }
        if let existing = try? context.fetch(FetchDescriptor(predicate: predicate)).first {
            context.delete(existing)
            saveContext()
        }
    }

    func getFavoriteFilms() -> [FilmDataModel] {
        let descriptor = FetchDescriptor<FilmDataModel>()
        return (try? context.fetch(descriptor)) ?? []
    }

    func saveFavorite(spaceship: Spaceship) {
        context.insert(SpaceshipDataModel(model: spaceship))
        saveContext()
    }

    func removeFavorite(spaceship: SpaceshipDataModel) {
        let id = spaceship.id.uuidString
        let predicate = #Predicate<SpaceshipDataModel> { $0.id.uuidString == id }
        if let existing = try? context.fetch(FetchDescriptor(predicate: predicate)).first {
            context.delete(existing)
            saveContext()
        }
    }

    func getFavoriteSpaceships() -> [SpaceshipDataModel] {
        let descriptor = FetchDescriptor<SpaceshipDataModel>()
        return (try? context.fetch(descriptor)) ?? []
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
