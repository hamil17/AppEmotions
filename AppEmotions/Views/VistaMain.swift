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
    @State var loginViewModel: LoginViewModel
    
    let columnas = [
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                   // Imagen principal
                    Image("imgMain")
                        .padding(.top, 180)
                    
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
            .navigationTitle("EmotionsConnect")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        NavigationLink {
                            VistaDashboard()
                        } label : {
                            HStack {
                                Text("Ver registros")
                                Image(systemName: "pencil")
                            }
//                            Text("Ver registros", systemImage: "pencil")
                        }
                        Divider()
                        Button ("Cerrar sesion", systemImage: "plus.square.on.square", role:.destructive) {
                            loginViewModel.logout()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
        }
    }
}

#Preview {
    var loginViewModel = LoginViewModel()
    VistaMain(loginViewModel: loginViewModel)
        
}
