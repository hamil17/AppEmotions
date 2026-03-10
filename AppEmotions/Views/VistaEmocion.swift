//
//  VistaEmocion.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 5 on 20/1/26.
//

import SwiftUI

struct VistaEmotionSingle: View {
//    @Environment(AppDataEmociones.self) var dataEmociones
    @State private var viewModel = VistaEmocionesViewModel()
    
    let emocion:Emocion
    
    var body: some View {
        ScrollView{
//            ForEach (dataEmociones.emociones) { emocion in
                VStack {
                    Text(emocion.nombre)
                }
                .padding(.top, 80)
                VStack {
                    Image ("imgAlegria")
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(red: 0.208, green: 0.247, blue: 0.329))
                        
                    VStack(alignment: .leading, spacing: 30) {
                        ScrollView(.horizontal){
                            HStack (spacing: 30){
                                Button {
                                    print("Me has hecho tap")
                                } label: {
                                    Text("Entiéndela")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color(red: 0.21, green: 0.91, blue: 0.69))
                                        .cornerRadius(10)

                                }
                                Button {
                                    print("Me has hecho tap")
                                } label: {
                                    Text("Vívela")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color(red: 0.21, green: 0.91, blue: 0.69))
                                        .cornerRadius(10)

                                }
                                Button {
                                    print("Me has hecho tap")
                                } label: {
                                    Text("Gestiónala")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color(red: 0.21, green: 0.91, blue: 0.69))
                                        .cornerRadius(10)

                                }
                                Button {
                                    print("Me has hecho tap")
                                } label: {
                                    Text("Hazme clic")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color(red: 0.21, green: 0.91, blue: 0.69))
                                        .cornerRadius(10)

                                }
                            }
                            
                        }
                        Text("Como se siente esta emoción:")
                            .foregroundStyle(Color.white)
                            .multilineTextAlignment(.leading)
                        Text(emocion.descripcion)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.vertical, 30)
                    .padding(.leading, 30)
                }
//            }
            .background(Color.gray.opacity(0.8))
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .ignoresSafeArea()
            }
            
    }
}

#Preview {
    VistaEmotionSingle(emocion: Emocion(nombre: "Alegría", descripcion: "...", color: "yellow", image: "Alegría"))
//    VistaEmotionSingle(emocion: Emocion)
}
