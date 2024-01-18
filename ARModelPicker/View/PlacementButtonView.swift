//
//  PlacementButtonView.swift
//  ARModelPicker
//
//  Created by Diki Dwi Diro on 19/01/24.
//

import SwiftUI

struct PlacementButtonView: View {
    
    // MARK: - Properties
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?
    
    // MARK: Body
    
    var body: some View {
        HStack(spacing: 30) {
            Button {
                resetPlacementParameters()
            } label: {
                CustomButtonView(string: "Cancel", 
                                 systemImage: "xmark")
            }
            
            Button {
                getConfirmedModelForPlacement()
                resetPlacementParameters()
                
            } label: {
                CustomButtonView(string: "Place", 
                                 systemImage: "checkmark")
            }
        }
    }
}

// MARK: - Private

private extension PlacementButtonView {
    private func resetPlacementParameters() {
        selectedModel = nil
        isPlacementEnabled = false
    }
    
    private func getConfirmedModelForPlacement() {
        modelConfirmedForPlacement = selectedModel
    }
}
