//
//  ColorPickerListView.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//


import SwiftUI

struct ColorPickerListView: View {
    let colors: [NamedColor]
    let onColorSelected: (NamedColor) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var filteredColors: [NamedColor] {
        if searchText.isEmpty {
            return colors
        } else {
            return colors.filter { 
                $0.name.localizedCaseInsensitiveContains(searchText) 
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredColors) { color in
                HStack {
                    Rectangle()
                        .fill(color.swiftColor)
                        .frame(width: 30, height: 30)
                        .cornerRadius(6)
                    
                    VStack(alignment: .leading) {
                        Text(color.name.colorLocalized)
                            .font(.headline)
                        Text(color.hex)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onColorSelected(color)
                    dismiss()
                }
            }
            .navigationTitle("Choose Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search colors...")
        }
    }
}
