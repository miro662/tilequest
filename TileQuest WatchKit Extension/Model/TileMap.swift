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
    
    func swap(_ pos1: IntVector, _ pos2: IntVector) {
        let pos1buf = getTile(at: pos1)
        setTile(tile: getTile(at: pos2), at: pos1)
        setTile(tile: pos1buf, at: pos2)
    }
    
    func map<M>(_ mapper: (T) -> M) -> TileMap<M> {
        return TileMap<M>(size: self.size, initialTileValueBuilder: {mapper(self.getTile(at: $0))})
    }
    
    func reduce<R>(initialValue: R, reducer: (IntVector, T, R) -> R) -> R{
        var value = initialValue;
        for position in size.rangeTo() {
            value = reducer(position, getTile(at: position), value)
        }
        return value
    }
    
    private func getPositionInBuf(of: IntVector) -> Int {
        return self.size.x * of.y + of.x
    }
}
