//
//  PersistenceController.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 13/02/23.
//

import CoreData

public struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Main")

        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
