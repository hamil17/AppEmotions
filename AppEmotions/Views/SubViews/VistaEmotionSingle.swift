//
//  VistaEmocion.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 5 on 20/1/26.
//

import SwiftUI

struct VistaEmotionSingle: View {
    
    @State private var itemSelecionado = 0
    
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
                        .fill(Color(red: 0.208, green: 0.247, blue: 0.329))
                        .frame(height: 700)
                        
                    VStack(alignment: .leading, spacing: 30) {
                        ScrollView(.horizontal){
                            HStack (spacing: 30){
                                Button {
                                    itemSelecionado = 0
                                } label: {
                                    Text("Entiéndela")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color(red: 0.21, green: 0.91, blue: 0.69))
                                        .cornerRadius(10)

                                }
                                Button {
                                    itemSelecionado = 1
                                } label: {
                                    Text("Vívela")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color(red: 0.21, green: 0.91, blue: 0.69))
                                        .cornerRadius(10)
                                }
                            }
                            
                        }
                        if (itemSelecionado == 0) {
                            EmocionEntiendela(emocion: emocion)
                        }
                        if (itemSelecionado == 1){
                            EmocionVivela(emocion:emocion)
                        }
                        
                    }
                    .padding(.vertical, 40)
                    .padding(.leading, 30)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .ignoresSafeArea()
                }
                .background(.gray.opacity(0.5))
            
    }
}

#Preview {
    VistaEmotionSingle(emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria"))
//    VistaEmotionSingle(emocion: Emocion)
}
