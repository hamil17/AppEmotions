//
//  EmocionVivela.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import SwiftUI

struct TagID: Identifiable {
    let id: Int
}

struct EmocionVivela: View {
    @Environment(\.dismiss) var dismiss
    @State private var mostrarModal = false
    @State private var tag: TagID?
    
    var emocion:Emocion
    
    var body: some View {
        let columnas = [
                GridItem(.flexible(), spacing: 20),
                GridItem(.flexible(), spacing: 20),
                GridItem(.flexible(), spacing: 20)
            ]
        
        LazyVGrid(columns: columnas, spacing: 10) {
            Button{
                mostrarModal = true
                tag = TagID(id: 1)
            } label: {
                SquareButton(image: "icoMedal", text: "Analiza")
            }
            
            Button{
                mostrarModal = true
                tag = TagID(id: 2)
            } label: {
                SquareButton(image: "icoSun", text: "Medita")
            }
            Button{
                mostrarModal = true
                tag = TagID(id: 3)
            } label: {
                SquareButton(image: "icoArrow", text: "Ejercita")
            }
            
            Button{
                mostrarModal = true
                tag = TagID(id: 4)
            } label: {
                SquareButton(image: "icoFlower", text: "Siente")
            }
            
            
        }
        .sheet(item: $tag, content: { item in
            if item.id == 1 {
                VistaAnaliza(emocion:emocion)
            }
            if item.id == 2 {
                VistaMedita(emocion:emocion)
            }
            if item.id == 3 {
                Text("Vista Ejercita")
            }
            if item.id == 4 {
                Text("Vista Siente")
            }
        })
        
        Spacer()
        
//        .sheet(isPresented: $mostrarModal) {
//            Button{
//                dismiss()
//            }label: {
//                Image(systemName: "x.cicle")
//            }
//            switch tag {
//                case 1:
//                    VistaAnaliza()
//                case 2:
//                    Text("Modal Medita")
//                case 3:
//                    Text("Modal Ejercita")
//                case 4:
//                    Text("Modal Siente")
//                default:
//                    Text("Nada selecionado")
//            }
//        }
    }
}

#Preview {
    EmocionVivela(emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
