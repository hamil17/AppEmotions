//
//  VistaEmocion.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 5 on 20/1/26.
//

import SwiftUI

struct VistaEmotionSingle: View {
    
    @State private var itemSelecionado = 0
    @State private var dailyStats = DailyStatsViewModel()
    
    let uid: String
    let emocion:Emocion
    
    var body: some View {
        ScrollView{
                VStack {
                    Text(emocion.nombre)
                        .font(.largeTitle)
                        .bold()
                }
//                .padding(.top, 80)
                VStack {
                    Image ("ico\(emocion.image)")
                }
                .padding(.bottom, 20)
            
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.customBlue)
                        .frame(height: 700)
                        
                    VStack(alignment: .leading, spacing: 30) {
                        ScrollView(.horizontal){
                            HStack (spacing: 30){
                                Button {
                                    itemSelecionado = 0
                                } label: {
                                    Text("Entiendela")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color.customGreen)
                                        .cornerRadius(10)

                                }
                                Button {
                                    itemSelecionado = 1
                                } label: {
                                    Text("Vívela")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color.customGreen)
                                        .cornerRadius(10)
                                }
                                Button {
                                    itemSelecionado = 2
                                } label: {
                                    Text("Gestiónala")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color.customGreen)
                                        .cornerRadius(10)
                                }
                            }
                            
                        }
                        if (itemSelecionado == 0) {
                            EmocionEntiendela(emocion: emocion)
                        }
                        if (itemSelecionado == 1){
                            EmocionVivela(uid: uid, emocion: emocion)
                        }
                        if (itemSelecionado == 2){
                            EmocionGestionala(uid: uid, emocion: emocion)
                        }
                        
                    }
                    .padding(.vertical, 40)
                    .padding(30)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .ignoresSafeArea()
                }
                .background(.gray.opacity(0.5))
            
        }
        .onAppear {
            dailyStats.markTask(uid: uid, task: .didExploreEmotion)
        }
}

#Preview {
    VistaEmotionSingle(uid: "preview-uid", emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
//    VistaEmotionSingle(emocion: Emocion)
}
