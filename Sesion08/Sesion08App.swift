//
//  Sesion08App.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

@main
struct Sesion08App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
