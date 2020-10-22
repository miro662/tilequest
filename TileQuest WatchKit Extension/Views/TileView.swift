//
//  TileView.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import SwiftUI

struct TileView: View {
    let tiledImage: UIImage
    let tilePosition: TilemapViewTile
    let tilemapSize: IntVector
    let empty = false
    
    func getCroppedImage(position: IntVector) -> UIImage {
        let cgImage = tiledImage.cgImage!
        let tileSizeX = cgImage.width / tilemapSize.x
        let tileSizeY = cgImage.height / tilemapSize.y
        let croppedCGImage = cgImage.cropping(to: CGRect(
                                                x: tileSizeX * position.x,
                                                y: tileSizeY * position.y,
                                                width: tileSizeX,
                                                height: tileSizeY))!
        return UIImage(cgImage: croppedCGImage)
    }
    
    @ViewBuilder var body: some View {
        switch tilePosition {
        case .tile(let position):
            Image(uiImage: self.getCroppedImage(position: position)).resizable()
        default:
            Spacer()
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleImage = UIImage(named: "TiledImage")!
        TileView(
            tiledImage: sampleImage,
            tilePosition: .tile(IntVector(x: 1, y: 1)),
            tilemapSize: IntVector(x: 3, y: 3)
        )
    }
}
