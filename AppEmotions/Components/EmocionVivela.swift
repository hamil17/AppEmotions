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
                VistaAnaliza()
            }
            if item.id == 2 {
                Text("Vista Medita")
            }
            if item.id == 3 {
                Text("Vista Ejercita")
            }
            if item.id == 4 {
                Text("Vista Siente")
            }
        })
        
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
    EmocionVivela()
}
