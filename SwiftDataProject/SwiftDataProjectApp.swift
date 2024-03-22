//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Shomil Singh on 22/03/24.
//
import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
        }
    }
}
