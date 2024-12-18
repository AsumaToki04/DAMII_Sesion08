//
//  TaskListView.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = TaskViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var isAddTask = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tarea.nombre, ascending: true)],
        animation: .default
    ) private var tareas: FetchedResults<Tarea>
    
    var body: some View {
        NavigationView {
            VStack {
                List(tareas) { item in
                    VStack(alignment: .leading) {
                        Text(item.nombre ?? "Sin nombre")
                            .font(.headline)
                        Text("Descripción: \(item.descripcion ?? "Sin descripción")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Etiqueta: \(item.etiqueta ?? "Sin etiqueta")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Prioridad: \(item.prioridad ?? "Sin prioridad")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Categoría: \(item.categoria ?? "Sin categoría")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Mis tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddTask = true
                    }) {
                        Label("Agregar", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}
