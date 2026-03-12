//
//  EmocionEntiendela.swift
//  AppEmotions
//
//  Created by Equipo 5 on 10/3/26.
//

import SwiftUI

struct EmocionEntiendela: View {
    
    var emocion:Emocion
    
    var body: some View {
        Text("Como se siente esta emoción:")
            .foregroundStyle(Color.white)
            .bold()
            .multilineTextAlignment(.leading)
        Text(emocion.descripcion)
            .foregroundStyle(Color.white)
        Spacer()
    }
}

#Preview {
    EmocionEntiendela(emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
