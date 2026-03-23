//
//  SquareButton.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import SwiftUI

struct SquareButton: View {
    
    let image: String
    let text: String
    let color: Color
    
    var body: some View {
        VStack {
                Image(image)
                Text(text)
                    .foregroundStyle(.white)
                    .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .cornerRadius(20)
        
    }
}

#Preview {
    SquareButton(image: "icoArrow", text: "Entiendela", color: Color.customBlue)
}
