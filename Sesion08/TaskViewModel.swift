//
//  TaskViewModel.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import CoreData

@MainActor
class TaskViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var completed: Bool = false
    @Published var selectPriority: Priority? = nil
    @Published var selectTag: Tag? = nil
    @Published var selectCategory: Category? = nil
    
    @Published var listTags: [Tag] = []
    @Published var listPriorities: [Priority] = []
    @Published var listCategories: [Category] = []
    
    let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func fetchOptions() async {
        do {
            listTags = try await AppServices.shared.getListTags()
            listPriorities = try await AppServices.shared.getListPriorities()
            listCategories = try await AppServices.shared.getListCategories()
        } catch {
            print("Error al cargar las listas: \(error.localizedDescription)")
        }
    }
    
    func createTask() {
        let newTask = Tarea(context: viewContext)
        newTask.id = UUID()
        newTask.nombre = name
        newTask.descripcion = description
        newTask.completado = completed
        newTask.prioridad = selectPriority?.name ?? "N/A"
        newTask.etiqueta = selectTag?.name ?? "N/A"
        newTask.categoria = selectCategory?.name ?? "N/A"
        confirmSave()
        resetValues()
    }
    
    func deleteTask(task: Tarea) {
        viewContext.delete(task)
        confirmSave()
    }
    
    private func confirmSave() {
        do {
            try viewContext.save()
        } catch {
            print("Error al guardar los cambios: \(error.localizedDescription)")
        }
    }
    
    func resetValues() {
        name = ""
        description = ""
        selectTag = nil
        selectPriority = nil
        selectCategory = nil
    }
}
