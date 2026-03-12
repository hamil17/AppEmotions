//
//  ContentView.swift
//  CursoiOS-AppEmociones
//
//  Created by Equipo 5 on 27/1/26.
//

import SwiftUI

struct VistaMain: View {
//    @Environment(VistaEmocionesViewModel.self) var appDataEmociones
//    @State private var authManager = AuthManager()
    @State var viewModel = EmocionesViewModel()
    
    let columnas = [
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Fila titulo + buscador
                    HStack {
                        Text("Emociones")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(Font.system(size: 25))
                            .padding(10)
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                    .padding(20)
                    .padding(.top, 60)
                    // imagen principal por ahora pongo el icono
                    VStack {
                        Image("imgMain")
                    }
                    // Texto
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(red: 0.208, green: 0.247, blue: 0.329))
                                .padding()
                                .frame(height: 90)
                            
                            Text(
                                "Elige una emoción y aprenderás lo que es,  como vivirla y como se puede gestionar"
                            )
                            .foregroundStyle(Color.white)
                            .padding()
                            
                        }
                    }
                    // Listado de emociones
                    ScrollView{
                        LazyVGrid(columns: columnas) {
                            ForEach(viewModel.emociones) { emocion in
                                NavigationLink {
                                    VistaEmotionSingle(emocion: emocion)
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(red: 0.208, green: 0.247, blue: 0.329))
                                            
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
//                    EmotionsList()
                    .padding()
                    
                }
            }
            .frame(maxHeight: .infinity)
            .background(.gray.opacity(0.5))
            .ignoresSafeArea()
        }
    }
}

#Preview {
//    @Previewable @State var dataEmociones = VistaEmocionesViewModel()
    VistaMain()
//        .environment(dataEmociones)
        
}
