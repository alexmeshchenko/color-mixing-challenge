//
//  ContentView.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 05.07.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedColorA: NamedColor?
    @State private var selectedColorB: NamedColor?
    @State private var nearestColor: NamedColor?
    
    @State private var showPickerA = false
    @State private var showPickerB = false
    
    @StateObject private var colorLoader = ColorLoader()
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            MainLayoutView(
                selectedColorA: $selectedColorA,
                selectedColorB: $selectedColorB,
                nearestColor: $nearestColor,
                showPickerA: $showPickerA,
                showPickerB: $showPickerB,
                colorLoader: colorLoader
            )
            
            LanguagePickerView()
                .padding(.bottom, 8)
                .padding(.leading, 0)
                .zIndex(1)
            
        }
        .sheet(isPresented: $showPickerA) {
            ColorPickerListView(colors: colorLoader.colors) { color in
                selectedColorA = color
            }
        }
        .sheet(isPresented: $showPickerB) {
            ColorPickerListView(colors: colorLoader.colors) { color in
                selectedColorB = color
            }
        }
        .onChange(of: selectedColorA) { updateNearestColor() }
        .onChange(of: selectedColorB) { updateNearestColor() }
        .padding()
    }
    
    // MARK: - Helpers
    
    func updateNearestColor() {
        guard selectedColorA != nil, selectedColorB != nil else {
            nearestColor = nil
            return
        }
        nearestColor = colorLoader.findNearestColor(to: mixedColor())
    }
    
    func mixedColor() -> Color {
        guard let a = selectedColorA, let b = selectedColorB else { return .gray }
        return a.swiftColor.mixed(with: b.swiftColor)
    }
}

#Preview {
    ContentView()
}
