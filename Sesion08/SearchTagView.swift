//
//  SearchTagView.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct SearchTagView: View {
    let tagList: [Tag]
    @Binding var selectedTag: Tag?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ForEach(tagList) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    if item.id == selectedTag?.id {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedTag = item
                    dismiss()
                }
            }
        }
        .navigationTitle("Seleccione etiqueta")
    }
}
