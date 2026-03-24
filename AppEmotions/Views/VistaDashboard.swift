//
//  VistaRegistros.swift
//  AppEmotions
//
//  Created by Equipo 5 on 16/3/26.
//

import SwiftUI
import Charts

struct TaskCheckRow: View {
    let title: String
    let description : String
    let completed: Bool
    
    var body: some View {
        HStack {
            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(completed ? Color.customBlue : .gray)
            VStack(alignment: .leading){
                Text(title)
                    .foregroundStyle(completed ? .primary : .secondary)
                    .font(.caption)
                Text(description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

struct VistaDashboard: View {
    let uid: String
    @State private var dailyStats = DailyStatsViewModel()
    @State private var showAvatarPicker: Bool = false
    @AppStorage("selectedAvatarModel") private var selectedModel: Int = 0
    
    private var nivelAvatar: Int {
        min(dailyStats.todayTasksCompleted, 4)
    }
    
    private var nombreAvatar: String {
        "avatar_\(selectedModel)_\(nivelAvatar)"
    }
    
    private var motivationalMessage: String {
        let completed = dailyStats.todayTasksCompleted
        let total = dailyStats.totalTasks
        
        switch completed {
        case 0:
            return "¡Empieza tu día!"
        case 1:
            return "¡Buen inicio!"
        case 2:
            return "¡Vas muy bien!"
        case 3:
            return "¡Casi lo tienes!"
        case total:
            return "¡Día completado!"
        default:
            return "¡Sigue adelante!"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                ScrollView{
                    VStack {
                        VStack(alignment: .leading){
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
                            Button {
                                showAvatarPicker = true
                            } label: {
                                Image(nombreAvatar)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 120)
                            }
                            .buttonStyle(.plain)
                            VStack(alignment: .leading){
                                Text(motivationalMessage)
                                    .font(.title2)
                                    .bold()
                                VStack(alignment: .leading, spacing: 12) {
                                    TaskCheckRow(title: "Explorar emociones", description: "(Solo entra a una emoción)", completed: dailyStats.taskExploreEmotionCompleted)
                                    TaskCheckRow(title: "Analizar una emoción", description: "(Emoción -> Analiza)", completed: dailyStats.taskAnalyzeCompleted)
                                    TaskCheckRow(title: "Meditar 30 segundos ", description: "(Emoción -> Medita)", completed: dailyStats.taskMeditateCompleted)
                                    TaskCheckRow(title: "Abrir Dashboard", description: "(Ya estas aquí (^_~)", completed: dailyStats.taskOpenDashboardCompleted)
                                }
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(15)
                            }
                        }
                        .padding(.bottom)
                        
                        
                        
                        VStack(alignment: .leading) {
                            ProgressView(value: dailyStats.todayProgress, total: 100)
                                .tint(Color.customBlue)
                                .scaleEffect(x: 1, y: 2, anchor: .center)
                            Text("\(Int(dailyStats.todayProgress))% completado (\(dailyStats.todayTasksCompleted)/\(dailyStats.totalTasks) objetivos)")
//                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                            
                            VStack{
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Accesos por día")
                                        .font(.headline)
                                    
                                    if dailyStats.recentAccessStats.isEmpty {
                                        Text("Aún no hay datos.")
                                            .foregroundStyle(.secondary)
                                    } else {
                                        Chart(dailyStats.recentAccessStats) { item in
                                            BarMark(
                                                x: .value("Día", item.date, unit: .day),
                                                y: .value("Accesos", item.accessCount)
                                            )
                                            .foregroundStyle(Color.customBlue)
                                        }
                                        .frame(height: 160)
                                    }
                                }
                                .padding(.vertical, 20)
                                
                                Divider()
                                    .padding(.top, 10)
                                    .padding(.bottom, 30)
                                
                                let columnas = [
                                    GridItem(.flexible(), spacing: 10),
                                    GridItem(.flexible(), spacing: 10)
                                ]
                                
                                LazyVGrid(columns: columnas, spacing: 10) {
                                    NavigationLink {
                                        VistaRegistroEmociones(uid: uid)
                                    } label: {
                                        SquareButton(image: "icoSun", text: "Registro de emociones", color: Color.customBlue)
                                    }
                                    NavigationLink {
                                        VistaListaRegistrosMalestar(uid: uid)
                                    } label: {
                                        SquareButton(image: "icoSun", text: "Registro de situación", color: Color.customBlue)
                                    }
                                    NavigationLink {
                                        VistaListaProsContras(uid: uid)
                                    } label: {
                                        SquareButton(image: "icoSun", text: "Resgistro de Pros y Contras", color: Color.customBlue)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.customYellow.gradient)
                            )
                            
                        

                            
                            
                            
                            
                        }
                    }
                }
                .padding(.top, 100)
                .navigationTitle("Dashboard")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.5))
        .ignoresSafeArea()
        .onAppear {
            dailyStats.markTask(uid: uid, task: .didOpenDashboard)
            dailyStats.listenToday(uid: uid)
            dailyStats.listenRecentAccess(uid: uid)
        }
        .sheet(isPresented: $showAvatarPicker) {
            AvatarPickerView()
        }
    }
}

#Preview {
    VistaDashboard(uid: "preview-uid")
}
