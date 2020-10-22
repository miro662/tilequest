//
//  IntVector.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import Foundation

struct IntVector {
    let x: Int;
    let y: Int;
    
    func contains(other: IntVector) -> Bool {
        return self.x >= other.x && self.y >= other.y
    }
}
