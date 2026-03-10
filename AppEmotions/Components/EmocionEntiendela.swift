//
//  EmocionEntiendela.swift
//  AppEmotions
//
//  Created by Equipo 5 on 10/3/26.
//

import SwiftUI

struct EmocionEntiendela: View {
    
//    var emocion:Emocion
    
    var body: some View {
        Text("Como se siente esta emoción:")
            .foregroundStyle(Color.white)
            .bold()
            .multilineTextAlignment(.leading)
//        Text(emocion.descripcion)
        Text("Hola")
            .foregroundStyle(Color.white)
        Spacer()
    }
}

#Preview {
    EmocionEntiendela()
}
