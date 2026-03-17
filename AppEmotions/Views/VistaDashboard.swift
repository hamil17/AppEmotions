//
//  VistaRegistros.swift
//  AppEmotions
//
//  Created by Equipo 5 on 16/3/26.
//

import SwiftUI

struct VistaDashboard: View {
    @State private var valor = 50.0
    @State private var mostrarModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
                ScrollView{
                    VStack {
                        HStack {
                            Text(Date.now.formatted(date: .complete, time: .omitted))
                                .font(.headline)
                            Spacer()
                        }
                        Divider()
                            .padding(.top)
                            .padding(.bottom)
                        HStack(alignment: .top){
                            Image("icoUserMale")
                            VStack{
                                Text("!Buen progreso!")
                                    .font(.title)
                                    .bold()
                                Text("Este progreso se mide según las emociones que has registrado hoy.")
                                    .padding(.top, 1)
                                
                            }
                        }
                        Slider(value: $valor,in: 0...100, step: 10)
                            .tint(Color.customBlue)
                        Text("tu progreso hoy es del \(Int(valor))%")
                    }
                    .padding()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.customGreen.gradient)
                            .frame(height: 700)
                        VStack(alignment: .leading){
                            let columnas = [
                                GridItem(.flexible(), spacing: 20),
                                GridItem(.flexible(), spacing: 20)
                            ]
                            
                            LazyVGrid(columns: columnas, spacing: 10) {
                                Button{
                                    mostrarModal = true
                    //                tag = TagID(id: 1)
                                } label: {
                                    SquareButton(image: "icoSun", text: "Tu registro de emociones", color: Color.customBlue)
                                }
                                Button{
                                    mostrarModal = true
                    //                tag = TagID(id: 1)
                                } label: {
                                    SquareButton(image: "icoSun", text: "Tu registro de malestar", color: Color.customBlue)
                                }
                            }
                            .sheet(isPresented: $mostrarModal){
//                                VistaRegistroMalestar(emocion:emocion)
                                Text("aqui la vista a mostrar")
                            }
                            Spacer()
                        }
                        .padding(40)
                    }
                }
                .padding(.top, 90)
                .navigationTitle("Dashboard")
        } // VStack principal
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.5))
        .ignoresSafeArea()
        
            
    }
}

#Preview {
    VistaDashboard()
}
