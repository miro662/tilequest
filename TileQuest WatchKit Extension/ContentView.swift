//
//  ContentView.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let sampleImage = UIImage(named: "TiledImage")!
        let tilemap = getTilemap()
        TilemapView(image: sampleImage, tilemap: tilemap, spacing: 5.0).navigationBarHidden(true)
    }
    
    private func getTilemap() -> TileMap<TilemapViewTile> {
        let size = IntVector(x: 4, y: 4)
        let tilemap = TileMap<TilemapViewTile>(size: size, initialTileValue: .tile(IntVector(x: 1, y: 1)))
        for x in 0..<size.x {
            for y in 0..<size.y {
                let position = IntVector(x: x, y: y)
                tilemap.setTile(tile: .tile(position), at: position)
            }
        }
        tilemap.setTile(tile: .empty, at: IntVector(x: 1, y: 1))
        return tilemap
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
