//
//  TileView.swift
//  Puzzle15Game
//
//  Created by Babypowder on 11/2/2567 BE.
//

import Foundation

class TileViewModel: ObservableObject {
    static let tiles = Array(1...16)
    @Published var isGameWon = false
    
    @Published private var model = Puzzle15GameModel<Int>(total: tiles.count) { index in
        tiles[index]
    }
    
    var tiles: [Puzzle15GameModel<Int>.Tile] {
        return model.tiles
    }
    
    var countMove: Int {
        return model.countMove
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ tile: Puzzle15GameModel<Int>.Tile) {
        model.choose(tile)
    
    }
    func checkGameWin() -> Bool {
            if model.isWon() {
                isGameWon = true
                return true
            }
        return false
        }
    
}

