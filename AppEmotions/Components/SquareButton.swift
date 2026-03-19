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
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            VStack {
                Image(image)
//                    .frame(width: 100, height: 100)
                Text(text)
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding()
        }
        
    }
}

#Preview {
    SquareButton(image: "icoArrow", text: "Entiendela", color: Color.customBlue)
}
