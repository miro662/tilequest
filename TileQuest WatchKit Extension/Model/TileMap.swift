//
//  TileMap.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import Foundation

class TileMap<T> {
    var buf: [T]
    let size: IntVector
    
    init(size: IntVector, initialTileValue: T) {
        self.size = size
        let capacity = size.x * size.y
        
        self.buf = [T](repeating: initialTileValue, count: capacity)
    }
    
    init(size: IntVector, initialTileValueBuilder: (IntVector) -> T) {
        self.size = size
        self.buf = []
        
        for position in self.size.rangeTo() {
            self.buf.append(initialTileValueBuilder(position))
        }
    }
    
    func getTile(at position: IntVector) -> T {
        let position = self.getPositionInBuf(of: position)
        return buf[position]
    }
    
    func setTile(tile: T, at position: IntVector) {
        let position = self.getPositionInBuf(of: position)
        buf[position] = tile
    }
    
    func map<M>(_ mapper: (T) -> M) -> TileMap<M> {
        return TileMap<M>(size: self.size, initialTileValueBuilder: {mapper(self.getTile(at: $0))})
    }
    
    private func getPositionInBuf(of: IntVector) -> Int {
        return self.size.x * of.y + of.x
    }
}
