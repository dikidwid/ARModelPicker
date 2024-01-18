//
//  Model.swift
//  ARModelPicker
//
//  Created by Diki Dwi Diro on 18/01/24.
//

import SwiftUI
import RealityKit
import Combine

class Model {

    // MARK: - Properties
    
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    // MARK: - Lifecycle
    
    init(modelName: String) {
        self.modelName = modelName
        
        self.image = UIImage(named: modelName) ?? UIImage()
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                print("\(loadCompletion)")
            }, receiveValue: { entity in
                self.modelEntity = entity
                
                // Assign a name to the created entity
                // for easy removal in the ARViewRepresentable.
                self.modelEntity?.name = modelName
            })
    }
}

extension Model: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(modelName)
    }
}

// MARK: - Equatable

extension Model: Equatable {
    static func == (lhs: Model, rhs: Model) -> Bool {
        lhs.modelName == rhs.modelName
    }
}
