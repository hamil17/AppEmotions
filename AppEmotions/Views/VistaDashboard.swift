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
    let completed: Bool
    
    var body: some View {
        HStack {
            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(completed ? .green : .gray)
            Text(title)
                .foregroundStyle(completed ? .primary : .secondary)
            Spacer()
        }
    }
}

struct VistaDashboard: View {
    let uid: String
    @State private var dailyStats = DailyStatsViewModel()
    
    private var motivationalMessage: String {
        let completed = dailyStats.todayTasksCompleted
        let total = DailyTaskId.allCases.count
        
        switch completed {
        case 0:
            return "¡Empieza tu día! 🌱"
        case 1:
            return "¡Buen inicio! Sigue así 🚀"
        case 2:
            return "¡Vas muy bien! 💪"
        case 3:
            return "¡Más de la mitad! 🎯"
        case total - 1:
            return "¡Casi lo tienes! 🔥"
        case total:
            return "¡Día completado! 🏆"
        default:
            return "¡Sigue adelante! ✨"
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
                            Image("icoUserMale")
                            VStack(alignment: .leading){
                                Text(motivationalMessage)
                                    .font(.title2)
                                    .bold()
                            }
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            TaskCheckRow(title: "Explorar emociones", completed: dailyStats.taskExploreEmotionCompleted)
                            TaskCheckRow(title: "Analizar una emoción", completed: dailyStats.taskAnalyzeCompleted)
                            TaskCheckRow(title: "Meditar 30 segundos", completed: dailyStats.taskMeditateCompleted)
                            TaskCheckRow(title: "Registrar malestar", completed: dailyStats.taskRegisterMalestarCompleted)
                            TaskCheckRow(title: "Abrir Dashboard", completed: dailyStats.taskOpenDashboardCompleted)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(15)
                        
                        ProgressView(value: dailyStats.todayProgress, total: 100)
                            .tint(Color.customBlue)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                        Text("\(Int(dailyStats.todayProgress))% completado (\(dailyStats.todayTasksCompleted)/\(DailyTaskId.allCases.count) objetivos)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
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
                                .padding(.vertical, 30)
                                
                                let columnas = [
                                    GridItem(.flexible(), spacing: 20),
                                    GridItem(.flexible(), spacing: 20)
                                ]
                                
                                LazyVGrid(columns: columnas, spacing: 10) {
                                    NavigationLink {
                                        VistaRegistroEmociones(uid: uid)
                                    } label: {
                                        SquareButton(image: "icoSun", text: "Tu registro de emociones", color: Color.customBlue)
                                    }
                                    NavigationLink {
                                        VistaListaRegistrosMalestar(uid: uid)
                                    } label: {
                                        SquareButton(image: "icoSun", text: "Tu registro de malestar", color: Color.customBlue)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.customGreen.gradient)
                            )

                            
                            
                            
                            
                        }
                    }
                }
                .padding(.top, 90)
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
    }
}

#Preview {
    VistaDashboard(uid: "preview-uid")
}
