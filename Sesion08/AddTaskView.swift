//
//  AddTaskView.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss // cerrar la vista actual
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Cargando...")
                    .onAppear {
                        Task {
                            await viewModel.fetchOptions()
                            isLoading = false
                        }
                    }
            } else {
                Form {
                    Section(header: Text("Información de la tarea")) {
                        TextField("Nombre", text: $viewModel.name)
                        TextField("Descripción", text: $viewModel.description)
                    }
                    Section(header: Text("Etiqueta")) {
                        NavigationLink(destination: SearchTagView(tagList: viewModel.listTags, selectedTag: $viewModel.selectTag)) {
                            Text("Seleccionar etiqueta")
                            Spacer()
                            Text(viewModel.selectTag?.name ?? "")
                                .foregroundColor(.gray)
                        }
                    }
                    Section(header: Text("Prioridad")) {
                        Picker("Seleccionar prioridad", selection: $viewModel.selectPriority) {
                            ForEach(viewModel.listPriorities) { item in
                                Text(item.name).tag(item as Priority?)
                            }
                        }
                    }
                    Section(header: Text("Categoría")) {
                        Menu {
                            ForEach(viewModel.listCategories) { item in
                                Button(action: {
                                    viewModel.selectCategory = item
                                }, label: {
                                    HStack {
                                        Text(item.name)
                                        if item == viewModel.selectCategory {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                })
                            }
                        } label: {
                            HStack {
                                Text("Seleccionar categoría")
                                Spacer()
                                Text(viewModel.selectCategory?.name ?? "Ninguna")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("Nueva Tarea")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Guardar") {
                            viewModel.createTask()
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            viewModel.resetValues()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
