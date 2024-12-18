//
//  Persistence.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name : "Sesion08")
        container.loadPersistentStores {_, error in
            if let err = error as? NSError {
                fatalError("Error al crear DB: \(err.localizedDescription)")
            }
        }
    }
}
