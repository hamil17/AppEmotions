//
//  EmocionGestionala.swift
//  AppEmotions
//
//  Created by Equipo 5 on 13/3/26.
//

import SwiftUI

struct TagIDGestion: Identifiable {
    let id: Int
}

struct EmocionGestionala: View {
    @State private var mostrarModal = false
    @State private var tag: TagIDGestion?
    
    let uid: String
    var emocion: Emocion
    
    var body: some View {
        let columnas = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
        
        LazyVGrid(columns: columnas, spacing: 10) {
            Button{
                mostrarModal = true
                tag = TagIDGestion(id: 1)
            } label: {
                SquareButton(image: "icoSun", text: "Registro de situación", color: Color.customGreen)
            }
            Button{
                mostrarModal = true
                tag = TagIDGestion(id: 2)
            } label: {
                SquareButton(image: "icoSun", text: "Registro de Pros / Contras", color: Color.customGreen)
            }
        }
//        .sheet(isPresented: $mostrarModal){
//            VistaRegistroMalestar(uid: uid, emocion: emocion)
//        }
        .sheet(item: $tag, content: { item in
            if item.id == 1 {
                VistaRegistroMalestar(uid: uid, emocion: emocion)
            }
            if item.id == 2 {
                VistaProContra(uid: uid, idEmocion: emocion.id ?? "")
            }
        })
        Spacer()
    }
}

#Preview {
    EmocionGestionala(uid: "preview-uid", emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
