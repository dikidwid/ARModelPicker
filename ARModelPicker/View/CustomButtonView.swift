//
//  CustomButtonView.swift
//  ARModelPicker
//
//  Created by Diki Dwi Diro on 19/01/24.
//

import SwiftUI

struct CustomButtonView: View {
    
    // MARK: - Properties
    
    let string: String
    let systemImage: String?
    
    // MARK: Body
    
    var body: some View {
        Label(string, systemImage: systemImage ?? "" )
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
            .tint(.primary.opacity(0.5))
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Material.ultraThin)
            }
    }
}
