//
//  ModelPickerView.swift
//  ARModelPicker
//
//  Created by Diki Dwi Diro on 19/01/24.
//

import SwiftUI

struct ModelPickerView: View {
    
    // MARK: - Properties
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    
    let models: [Model]
    
    // MARK: Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0..<models.count, id: \.self) { index in
                    Button {
                        selectedModel = models[index]
                        isPlacementEnabled = true
                    } label: {
                        Image(uiImage: UIImage(named: models[index].modelName) ?? UIImage())
                            .resizable()
                            .frame(width: 75, height: 75)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Material.ultraThin))
        }
        .padding()
    }
}
