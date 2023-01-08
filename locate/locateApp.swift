//
//  locateApp.swift
//  locate
//
//  Created by Einas Alturki on 15/06/1444 AH.
//

import SwiftUI

@main
struct locateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
