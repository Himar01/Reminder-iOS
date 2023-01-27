//
//  ReminderApp.swift
//  Reminder
//
//  Created by Rita Ithaisa on 27/1/23.
//

import SwiftUI

@main
struct ReminderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
