//
//  GameState.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 24/10/2020.
//

import Foundation

enum Tile {
    case occupied(IntVector)
    case empty
}

enum Direction {
    case up
    case left
    case down
    case right
}

class GameState {
    let map: TileMap<Tile>
    let size: IntVector
    let empty: IntVector
    
    private init(map: TileMap<Tile>, size: IntVector, empty: IntVector) {
        self.map = map
        self.size = size
        self.empty = empty
    }
    
    static func correct(size: IntVector) -> GameState {
        let empty = IntVector(x: size.x - 1, y: size.y - 1)
        let map = TileMap<Tile>(size: size, initialTileValueBuilder: {position in
            if position == empty {
                return Tile.empty
            } else {
                return Tile.occupied(position)
            }
        })
        return GameState(map: map, size: size, empty: empty)
    }
    
    var availableDirections: [Direction] {
        var directions: [Direction] = []
        if empty.x > 0 {
            directions.append(.right)
        }
        if empty.y > 0 {
            directions.append(.down)
        }
        if empty.x < size.x - 1 {
            directions.append(.left)
        }
        if empty.y < size.y - 1 {
            directions.append(.up)
        }
        return directions
    }
    
    func moved(_ direction: Direction) -> GameState? {
        if let newEmpty = getSwappedElementPosition(direction) {
            let clonedMap = map.map {$0}
            clonedMap.swap(empty, newEmpty)
            return GameState(map: clonedMap, size: size, empty: newEmpty)
        }
        return .none
    }
    
    func getDirectionForTileAt(position: IntVector) -> Direction? {
        let directions: [Direction] = [.up, .left, .down, .right]
        for direction in directions {
            if getSwappedElementPosition(direction) == position {
                return direction
            }
        }
        return .none
    }
    
    func getSwappedElementPosition(_ direction: Direction) -> IntVector? {
        if !availableDirections.contains(direction) {
            return .none
        }
        
        switch direction {
        case .up:
            return IntVector(x: empty.x, y: empty.y + 1)
        case .left:
            return IntVector(x: empty.x + 1, y: empty.y)
        case .down:
            return IntVector(x: empty.x, y: empty.y - 1)
        case .right:
            return IntVector(x: empty.x - 1, y: empty.y)
        }
    }
}
