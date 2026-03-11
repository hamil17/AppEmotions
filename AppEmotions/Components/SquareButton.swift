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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.235, green: 0.918, blue: 0.663))
            VStack {
                Image(image)
                    .frame(width: 100, height: 100)
                Text(text)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding()
        }
        
    }
}

#Preview {
    SquareButton(image: "icoArrow", text: "Entiendela")
}
