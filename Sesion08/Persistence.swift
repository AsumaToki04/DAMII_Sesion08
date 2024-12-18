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
            if let er = error as? NSError {
                fatalError("No se pudo conectar a la BD: \(er)")
            }
        }
    }
}
