//
//  IntVector.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import Foundation

struct IntVector: CustomStringConvertible, Equatable {
    let x: Int;
    let y: Int;
    
    func contains(other: IntVector) -> Bool {
        return self.x >= other.x && self.y >= other.y
    }
    
    func rangeTo() -> IntVectorIterator {
        return IntVectorIterator(self)
    }
    
    var description: String {
        return "(\(x), \(y))"
    }
}

struct IntVectorIterator: Sequence, IteratorProtocol {
    private let vector: IntVector
    private var nextPosition: IntVector? = IntVector(x: 0, y: 0)
    
    init(_ vector: IntVector) {
        self.vector = vector
    }
    
    mutating func next() -> IntVector? {
        if let currentPosition = nextPosition {
            nextPosition = getNextVector(currentPosition)
            return currentPosition
        }
        return .none
    }
    
    private func getNextVector(_ current: IntVector) -> IntVector? {
        var next = IntVector(x: current.x + 1, y: current.y)
        
        if next.x >= vector.x {
            next = IntVector(x: 0, y: current.y + 1)
        }
        if next.y >= vector.y {
            return .none
        }
        return next
    }
}
