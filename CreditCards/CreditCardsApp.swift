//
//  CreditCardsApp.swift
//  CreditCards
//
//  Created by Yery Castro on 8/3/23.
//

import SwiftUI

@main
struct CreditCardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
