//
//  TilemapView.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import SwiftUI

enum TilemapViewTile {
    case tile(IntVector)
    case empty
}

struct TilemapView: View {
    let image: UIImage
    let tilemap: TileMap<TilemapViewTile>
    let spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<tilemap.size.x) { x in
                tileColumn(col: x)
            }
        }
        .frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity).aspectRatio(1.0, contentMode: .fill)
    }
    
    private func tile(at position: IntVector) -> some View {
        let tile = tilemap.getTile(at: position)
        return TileView(tiledImage: self.image, tilePosition: tile, tilemapSize: tilemap.size).aspectRatio(1, contentMode: .fit)

    }
    
    private func tileColumn(col: Int) -> some View {
        VStack(spacing: spacing) {
            ForEach(0..<tilemap.size.y) { y in
                tile(at: IntVector(x: col, y: y))
            }
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
    }
    
}

struct TilemapView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleImage = UIImage(named: "TiledImage")!
        TilemapView(image: sampleImage, tilemap: getTilemap(), spacing: 6.0)
    }

    private static func getTilemap() -> TileMap<TilemapViewTile> {
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

