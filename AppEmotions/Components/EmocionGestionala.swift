//
//  EmocionGestionala.swift
//  AppEmotions
//
//  Created by Equipo 5 on 13/3/26.
//

import SwiftUI

struct EmocionGestionala: View {
    @State private var mostrarModal = false
    
    var emocion: Emocion
    
    var body: some View {
        let columnas = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
        
        LazyVGrid(columns: columnas, spacing: 10) {
            Button{
                mostrarModal = true
//                tag = TagID(id: 1)
            } label: {
                SquareButton(image: "icoSun", text: "Registro de malestar (Lowlights)")
            }
        }
        .sheet(isPresented: $mostrarModal){
            VistaRegistroMalestar()
        }
        Spacer()
    }
}

#Preview {
    EmocionGestionala(emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
