//
//  Puzzle15GameModel.swift
//  Puzzle15Game
//
//  Created by Babypowder on 11/2/2567 BE.
//

import Foundation

struct Puzzle15GameModel<TileContentType: Equatable> {
    private(set) var tiles: Array<Tile>
    private(set) var spaceIndex: Int
    private(set) var countMove: Int = 0
//    private(set) var showWin = false

    
    init(total: Int, tileContentFactory: (Int) -> TileContentType) {
        tiles = []
        for index in 0..<total {
            let content = tileContentFactory(index)
            tiles.append(Tile(isSpace: index == total - 1, content: content))
        }
        spaceIndex = total-1
        shuffle()
    }
    
    mutating func choose(_ tile: Tile) {
        let chosenIndex = index(of: tile)
        guard chosenIndex != spaceIndex else { return }
        
        if canMove(to: chosenIndex) {
            tiles.swapAt(chosenIndex, spaceIndex)
            spaceIndex = chosenIndex
            countMove += 1
            
//            if isWon() {
//                showWin = true
//            }
        }
    }
    

    func isWon() -> Bool {
        for index in 0..<tiles.count {
            if !tiles[index].isSpace {
                guard let content = tiles[index].content as? Int else {
                    return false
                }
                if content != index + 1 {
                    return false
                }
            }
        }
        return true
    }

    private func canMove(to index: Int) -> Bool {
        let rowDiff = abs(index / 4 - spaceIndex / 4)
        let colDiff = abs(index % 4 - spaceIndex % 4)
        return (rowDiff == 0 && colDiff == 1) || (rowDiff == 1 && colDiff == 0)
    }
    
    private func index(of tile: Tile) -> Int {
            for index in tiles.indices {
                if tiles[index].id ==  tile.id {
                    return index
                }
            }
            return 0;
        }
    
    mutating func shuffle() {
        countMove = 0
        let moves = 1000
        for _ in 0..<moves {
            var move: [Int] = []
            for i in 0..<tiles.count {
                if canMove(to: i) {
                    move.append(i)
                }
            }
            let randomIndex = Int.random(in: 0..<move.count)
            let randomMoveIndex = move[randomIndex]
            tiles.swapAt(spaceIndex, randomMoveIndex)
            spaceIndex = randomMoveIndex
        }

    }


    struct Tile: Identifiable, Equatable {
        var isSpace: Bool
        let content: TileContentType
        let id = UUID()
    }
}


