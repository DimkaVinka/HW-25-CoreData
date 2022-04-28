//
//  HW_25_CoreDataApp.swift
//  HW-25 CoreData
//
//  Created by Дмитрий Виноградов on 28.04.2022.
//

import SwiftUI

@main
struct HW_25_CoreDataApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
