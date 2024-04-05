//
//  MainViewModel.swift
//  Shambaboocly
//
//  Created by Arseniy Apollonov on 04.04.2024.
//

import UIKit

enum CellState: CaseIterable {
    case dead
    case alive
    case life
    
    func getImageName() -> String {
        switch self {
        case .dead:
            return "deadImage"
        case .alive:
            return "aliveImage"
        case .life:
            return "lifeImage"
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .dead:
            return "Мертвая"
        case .alive:
            return "Живая"
        case .life:
            return "Жизнь"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .dead:
            return "или прикидывается"
        case .alive:
            return "и шевелится!"
        case .life:
            return "Ку-ку!"
        }
    }
}

final class MainViewModel {
    var cellsArray: [CellState] = []
    private var lastThreeCells: [CellState] = []
    
    func addNewCell() {
        let newCell = Bool.random() ? CellState.alive : CellState.dead
        
        cellsArray.append(newCell)
        lastThreeCells.append(newCell)
        
        if lastThreeCells.count > 3 {
            lastThreeCells.removeFirst()
        }
        
        guard lastThreeCells.count == 3 else { return }
        
        if (lastThreeCells.allSatisfy({ $0 == .alive })) {
            createLife()
            lastThreeCells.removeFirst()
        } else if (lastThreeCells.allSatisfy({ $0 == .dead })) {
            killLife()
            lastThreeCells = []
        }
    }
    
    private func createLife() {
        cellsArray.append(.life)
        lastThreeCells.append(.life)
    }
    
    private func killLife() {
        if let lastAliveCell = cellsArray.lastIndex(where: { $0 == .life }) {
            cellsArray.remove(at: lastAliveCell)
        }
    }
}
