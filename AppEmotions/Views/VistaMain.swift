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
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                   // Imagen principal
                    Image("imgMain")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
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
                    LazyVGrid(columns: columnas, spacing: 20) {
                        ForEach(viewModel.emociones) { emocion in
                            NavigationLink {
                                VistaEmotionSingle(uid: uid, emocion: emocion)
                            } label: {
                                VStack {
                                        Image("ico\(emocion.image)")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .aspectRatio(contentMode: .fill)
                                        Text("Hola, soy...")
                                            .foregroundStyle(Color.white)
                                        Text(emocion.nombre)
                                            .foregroundStyle(Color.white)
                                            .font(.title)
                                            .bold()
//                                        }
                                }
                                .padding(.top, 20)
                                .padding(.bottom, 60)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
//                                        .fill(Color.customBlue.gradient)
                                        .fill(
                                                    LinearGradient(
                                                        stops: [
                                                            .init(color: .customBlue.opacity(0.9), location: 0.1), // Empieza suave al 30%
                                                            .init(color: .customBlue, location: 0.6)              // Termina sólido al final
                                                        ],
                                                        startPoint: .top,
                                                        endPoint: .bottom
                                                    )
                                                )
                                        // Aplicamos el skew solo al fondo
                                        .transformEffect(.init(a: 1, b: -0.2, c: 0, d: 1, tx: 0, ty: 0))
                                }
                            }
                        }
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 10)
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
