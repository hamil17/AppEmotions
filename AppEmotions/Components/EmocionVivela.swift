//
//  EmocionVivela.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import SwiftUI

struct EmocionVivela: View {
    
    @State private var MostrarModal = false
    @State private var tag = 0
    
    var body: some View {
        let columnas = [
                GridItem(.flexible(), spacing: 20),
                GridItem(.flexible(), spacing: 20),
                GridItem(.flexible(), spacing: 20)
            ]
        
        LazyVGrid(columns: columnas, spacing: 10) {
            Button{
                MostrarModal = true
                tag = 1
            } label: {
                SquareButton(image: "icoMedal", text: "Analiza")
            }
            
            Button{
                MostrarModal = true
                tag = 2
            } label: {
                SquareButton(image: "icoSun", text: "Medita")
            }
            
            SquareButton(image: "icoArrow", text: "Ejercita")
            
            SquareButton(image: "icoFlower", text: "Siente")
            
        }
        .sheet(isPresented: $MostrarModal) {
            if(tag == 1){
                VistaEjercita()
            }
            if(tag == 2){
                Text("Holaaa")
            }
            
        }
    }
}

#Preview {
    EmocionVivela()
}
