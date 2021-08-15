//
//  ListinhaDePulsoApp.swift
//  ListinhaDePulso
//
//  Created by Leonardo Gomes on 14/08/21.
//

import SwiftUI

@main
struct ListinhaDePulsoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
