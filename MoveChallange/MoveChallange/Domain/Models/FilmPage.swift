//
//  Film.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

struct FilmPage {
    let count: Int
    let hasNext: Bool
    let hasPrevious: Bool
    let results: [Film]

    init(dto: FilmPageDTO) {
        self.count = dto.count
        self.hasNext = dto.next != nil
        self.hasPrevious = dto.previous != nil
        self.results = dto.results.map { Film(dto: $0) }
    }
}
