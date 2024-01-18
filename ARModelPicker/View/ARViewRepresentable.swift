//
//  ARViewRepresentable.swift
//  ARModelPicker
//
//  Created by Diki Dwi Diro on 19/01/24.
//

import SwiftUI
import RealityKit

struct ARViewRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    
    @Binding var modelConfirmedForPlacement: Model?
    @Binding var shouldRemoveAllModels: Bool
    
    let models: [Model]
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> ARView {
        CustomARView(frame: .zero)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if shouldRemoveAllModels {
            removeAllModelsExisted(in: uiView)
        } else if let model = modelConfirmedForPlacement {
            addThis(model, to: uiView)
        }
    }
}

// MARK: - Private

private extension ARViewRepresentable {
    func removeAllModelsExisted(in uiView: ARView) {
        #warning("Find an alternative way to remove all entities exist")
        uiView.scene.anchors.forEach { anchor in
            anchor.children.forEach { entity in
                for model in models {
                    if let foundEntity = entity.findEntity(named: model.modelName) {
                        foundEntity.removeFromParent()
                    }
                }
            }
        }
        DispatchQueue.main.async {
            shouldRemoveAllModels = false
        }
    }
    
    func addThis(_ model: Model, to uiView: ARView) {
        if let modelEntity = model.modelEntity {
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity .clone(recursive: true))
            uiView.scene.addAnchor(anchorEntity)
            DispatchQueue.main.async {
                modelConfirmedForPlacement = nil
                
            }
        }
    }
}
