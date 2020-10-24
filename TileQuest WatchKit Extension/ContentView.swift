//
//  ContentView.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import SwiftUI

struct ContentView: View {
    static let shuffles = 64
    @State var gameState: GameState = GameState.shuffled(times: shuffles, size: IntVector(x: 4, y: 4))
    
    var body: some View {
        let sampleImage = UIImage(named: "TiledImage")!
        
        ZStack {
            TilemapView(image: sampleImage, tilemap: tilemap, spacing: 5.0, onTileTapped: {position in
                if (!gameState.correct) {
                    moveTile(at: position)
                }
            }).navigationBarHidden(true)
            
            if (gameState.correct) {
                VictoryView(onPlayAgain: {
                    gameState = GameState.shuffled(times: ContentView.shuffles, size: IntVector(x: 4, y: 4))
                })
            }
        }
    }
    
    var tilemap: TileMap<TilemapViewTile> {
        gameState.map.map {
            switch $0 {
            case Tile.occupied(let position):
                return TilemapViewTile.tile(position)
            case Tile.empty:
                return TilemapViewTile.empty
            }
        }
    }
    
    func moveTile(at position: IntVector) {
        if let direction = gameState.getDirectionForTileAt(position: position) {
            print(gameState.availableDirections.description)
            if let newState = gameState.moved(direction) {
                gameState = newState
            }
        } else {
            // invaild tile
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
