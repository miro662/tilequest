//
//  ContentView.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var gameState: GameState = GameState.correct(size: IntVector(x: 4, y: 4))
    
    var body: some View {
        let sampleImage = UIImage(named: "TiledImage")!
        let tilemap: TileMap<TilemapViewTile> = gameState.map.map {
            switch $0 {
            case Tile.occupied(let position):
                return TilemapViewTile.tile(position)
            case Tile.empty:
                return TilemapViewTile.empty
            }
        }
        TilemapView(image: sampleImage, tilemap: tilemap, spacing: 5.0, onTileTapped: {
            position in print(position.description)
        }).navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
