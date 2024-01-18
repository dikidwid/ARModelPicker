//
//  ContentView.swift
//  ARModelPicker
//
//  Created by Diki Dwi Diro on 18/01/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    // MARK: - Properties
    
    @State private var isPlacementEnabled = true
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    @State private var shouldRemoveAllModels = false
    
    private var models: [Model] = {
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath,
              let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return [] }
        
        return files
            .filter { $0.hasSuffix(".usdz") }
            .compactMap { $0.replacingOccurrences(of: ".usdz", with: "") }
            .compactMap { Model(modelName: $0 ) }
    }()
    
    // MARK: Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewRepresentable(modelConfirmedForPlacement: $modelConfirmedForPlacement,
                                shouldRemoveAllModels: $shouldRemoveAllModels,
                                models: models).ignoresSafeArea()
        
            VStack {
                Button {
                    shouldRemoveAllModels = true
                } label: {
                    CustomButtonView(string: "Clear",
                                     systemImage: "trash")
                }
                
                Spacer()
                
                if isPlacementEnabled {
                    PlacementButtonView(isPlacementEnabled: $isPlacementEnabled,
                                        selectedModel: $selectedModel,
                                        modelConfirmedForPlacement: $modelConfirmedForPlacement)
                } else {
                    ModelPickerView(isPlacementEnabled: $isPlacementEnabled,
                                    selectedModel: $selectedModel,
                                    models: models)
                }
            }
            
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
