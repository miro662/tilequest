//
//  TileMap.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import Foundation

enum TileMapError: Error {
    case outOfBounds
}

class TileMap<T> {
    var buf: [T]
    let size: IntVector
    
    init(size: IntVector, initialTileValue: T) {
        self.size = size
        let capacity = size.x * size.y
        
        self.buf = [T](repeating: initialTileValue, count: capacity)
    }
    
    func getTile(at position: IntVector) throws -> T {
        let position = try self.getPositionInBuf(of: position)
        return buf[position]
    }
    
    func setTile(tile: T, at position: IntVector) throws {
        let position = try self.getPositionInBuf(of: position)
        buf[position] = tile
    }
    
    private func getPositionInBuf(of: IntVector) throws -> Int {
        if self.size.contains(other: of) {
            return self.size.x * of.y + of.x
        } else {
            throw TileMapError.outOfBounds
        }
    }
}
