//
//  FilterCharacterGenderUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol FilterCharacterGenderUseCaseProtocol {
    func execute(characters: [StarCharacter], on gender: StarCharacter.Gender) -> [StarCharacter]
}

final class FilterCharacterGenderUseCase: FilterCharacterGenderUseCaseProtocol {
    func execute(characters: [StarCharacter], on gender: StarCharacter.Gender) -> [StarCharacter] {
        return characters.filter { $0.gender == gender }
    }
}
