//
//  quick_todoApp.swift
//  quick todo
//
//  Created by Daim Armaghan on 14/06/2023.
//

import SwiftUI

@main
struct quick_todoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            todoview()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
