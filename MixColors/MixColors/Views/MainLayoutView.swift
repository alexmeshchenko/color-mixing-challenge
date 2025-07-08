//
//  MainLayoutView.swift
//  MixColors
//
//  Created by Aleksandr Meshchenko on 08.07.25.
//


import SwiftUI

struct MainLayoutView: View {
    @Binding var selectedColorA: NamedColor?
    @Binding var selectedColorB: NamedColor?
    @Binding var nearestColor: NamedColor?
    
    @Binding var showPickerA: Bool
    @Binding var showPickerB: Bool
    
    @ObservedObject var colorLoader: ColorLoader
    
    @Environment(\.locale) private var locale
    
    var body: some View {
        VStack(spacing: 24) {
            Text("MIXCOLORS".uiLocalized)
                .font(.title)
                .padding(.top)
            
            VStack {
                Text(selectedColorA?.name.colorLocalized ?? "SELECT".uiLocalized)
                Rectangle()
                    .fill(selectedColorA?.swiftColor ?? .gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    .onTapGesture { showPickerA = true }
            }
            
            Text("+").font(.title)
            
            VStack {
                Text(selectedColorB?.name.colorLocalized ?? "SELECT".uiLocalized)
                Rectangle()
                    .fill(selectedColorB?.swiftColor ?? .gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    .onTapGesture { showPickerB = true }
            }
            
            Text("=").font(.title)
            
            VStack {
                Text(nearestColor?.name.colorLocalized ?? "RESULT".uiLocalized)
                Rectangle()
                    .fill(mixedColor())
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func mixedColor() -> Color {
        guard let a = selectedColorA, let b = selectedColorB else { return .gray }
        return a.swiftColor.mixed(with: b.swiftColor)
    }
}
