//
//  ToDoApplicationApp.swift
//  ToDoApplication
//
//  Created by Roman Krusman on 01.03.2024.
//

import SwiftUI
import TipKit

@main
struct ToDoApplicationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    init () {
        try? Tips.resetDatastore()
        try? Tips.configure()
    }
}
