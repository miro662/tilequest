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

class GameState {
    let map: TileMap<Tile>
    let size: IntVector
    
    private init(map: TileMap<Tile>, size: IntVector) {
        self.map = map
        self.size = size
    }
    
    static func correct(size: IntVector) -> GameState {
        let last = IntVector(x: size.x - 1, y: size.y - 1)
        let map = TileMap<Tile>(size: size, initialTileValueBuilder: {position in
            if position == last {
                return Tile.empty
            } else {
                return Tile.occupied(position)
            }
        })
        return GameState(map: map, size: size)
    }
    
    
}
