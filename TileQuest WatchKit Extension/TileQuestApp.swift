//
//  TileQuestApp.swift
//  TileQuest WatchKit Extension
//
//  Created by Mirosław Błażej on 22/10/2020.
//

import SwiftUI

@main
struct TileQuestApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
