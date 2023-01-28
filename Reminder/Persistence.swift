//
//  Persistence.swift
//  Reminder
//
//  Created by Rita Ithaisa on 27/1/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<2 {
            let newItem = TaskReminder(context: viewContext)
            newItem.date = Date()
            newItem.completed = true
            newItem.name = "Tarea básica"
            newItem.notes = "Tarea sobre el destino del sabio"
            newItem.isMind = false
            newItem.id = Int64(i)
        }
        for _ in 0..<1 {
            let newItem = TaskReminder(context: viewContext)
            newItem.date = Date()
            newItem.completed = false
            newItem.name = "Tarea compleja"
            newItem.notes = "Tarea sobre el destino del sabio"
            newItem.isMind = false
            newItem.id = 2
        }
        for i in 0..<4 {
            let newItem = TaskReminder(context: viewContext)
            newItem.date = Date()
            newItem.completed = false
            newItem.name = "Tarea compleja mente"
            newItem.notes = "Tarea sobre el destino del sabio"
            newItem.isMind = true
            newItem.id = Int64(3+i)
        }
        for _ in 0..<1 {
            let newItem = TaskReminder(context: viewContext)
            newItem.date = Date()
            newItem.completed = true
            newItem.name = "Tarea compleja mente"
            newItem.notes = "Tarea sobre el destino del sabio"
            newItem.isMind = true
            newItem.id = 7
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Reminder")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
