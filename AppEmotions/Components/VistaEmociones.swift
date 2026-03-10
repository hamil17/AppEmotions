//
//  CardListItem.swift
//  CursoiOS-AppEmociones
//
//  Created by Equipo 5 on 3/2/26.
//

import SwiftUI

struct VistaEmotionsList: View {
    @State var viewModel = VistaEmocionesViewModel()
    
//    @State private var mostrarEmocion = false
//    @State private var emocionSeleccionada: Emocion?
    
    let columnas = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: columnas) {
                    ForEach(viewModel.emociones) { emocion in
                        NavigationLink {
                            VistaEmotionSingle(emocion: emocion)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 0.208, green: 0.247, blue: 0.329))
                                //                                .fill(emocion.color)
                                
                                    VStack {
                                        Image("ico\(emocion.image)")
                                            .frame(width: 100, height: 100)
                                        Text("Hola, soy...")
                                            .foregroundStyle(Color.white)
                                        Text(emocion.nombre)
                                            .foregroundStyle(Color.white)
                                            .font(.custom("", size: 23))
                                            .bold()
                                    }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    VistaEmotionsList()
}
