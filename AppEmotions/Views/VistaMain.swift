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
    @State private var dailyStats = DailyStatsViewModel()
    let uid: String
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
                            Text(
                                "Elige una emoción y descubre cómo funciona en tu cuerpo y mente, convirtiéndola en aliada de tu proceso personal o terapéutico."
                            )
                            .foregroundStyle(Color.white)
                    }
                    .padding()
                    .background(Color.customBlue)
                    .cornerRadius(10)
                    .padding(10)
                    // Listado de emociones
                    
                        LazyVGrid(columns: columnas) {
                            ForEach(viewModel.emociones) { emocion in
                                NavigationLink {
                                    VistaEmotionSingle(uid: uid, emocion: emocion)
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.customBlue)
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
                    
//                    EmotionsList()
                    .padding()
                    
                }
            }
            .background(.gray.opacity(0.5))
            .ignoresSafeArea()
            .overlay(alignment: .bottomTrailing) {
                AvatarFlotante(tareasCompletadas: dailyStats.todayTasksCompleted)
                    .padding()
            }
            .navigationTitle("EmotionsConnect")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        NavigationLink {
                            VistaDashboard(uid: uid)
                        } label : {
                            HStack {
                                Text("Dashboard")
                                Image(systemName: "person.crop.circle")
                            }
//                            Text("Ver registros", systemImage: "pencil")
                        }
                        Divider()
                        Button ("Cerrar sesion", systemImage: "xmark.circle", role:.destructive) {
                            loginViewModel.logout()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
        }
        .onAppear {
            dailyStats.trackMainAccess(uid: uid)
            dailyStats.listenToday(uid: uid)
        }
    }
}

#Preview {
    let loginViewModel = LoginViewModel()
    VistaMain(uid: "preview-uid", loginViewModel: loginViewModel)
        
}
