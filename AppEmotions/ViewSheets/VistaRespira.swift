//
//  VistaRespira.swift
//  AppEmotions
//
//  Created by Equipo 5 on 23/3/26.
//

import SwiftUI
import AudioToolbox

enum TecnicaRespiracion: String, CaseIterable {
    case cuatroDosSeis = "4-2-6"
    case cuatroDosSeisDos = "4-2-6-2"
    
    var pasos: [(fase: String, duracion: Double)] {
        switch self {
        case .cuatroDosSeis:
            return [("Inhalar", 4), ("Mantener", 2), ("Exhalar", 6)]
        case .cuatroDosSeisDos:
            return [("Inhalar", 4), ("Mantener", 2), ("Exhalar", 6), ("Mantener", 2)]
        }
    }
}

struct VistaRespira: View {
    @Environment(\.dismiss) var dismiss
    @State private var tecnicaSeleccionada: TecnicaRespiracion = .cuatroDosSeis
    @State private var estaActivo: Bool = false
    @State private var pasoActual: Int = 0
    @State private var progresoFase: Double = 0
    @State private var segundosMostrados: Int = 0
    @State private var repeticiones: Int = 0
    @State private var timer: Timer?
    @State private var tiempoInicioFase: Date = Date()
    
    private var duracionFaseActual: Double {
        tecnicaSeleccionada.pasos[pasoActual].duracion
    }
    
    private var faseActual: String {
        tecnicaSeleccionada.pasos[pasoActual].fase
    }
    
    private var esFaseInhalar: Bool {
        faseActual == "Inhalar"
    }
    
    private var esFaseExhalar: Bool {
        faseActual == "Exhalar"
    }
    
    private var esFaseMantener: Bool {
        faseActual == "Mantener"
    }
    
    private var colorFase: Color {
        esFaseMantener ? .red : (esFaseInhalar ? .cyan : .mint)
    }
    
    private var progresoAnimado: Double {
        if !estaActivo { return 0 }
        
        if esFaseMantener {
            return 1
        } else if esFaseInhalar {
            return 1 - progresoFase
        } else {
            return progresoFase
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Aquí puedes ejercitar respiraciones para bajar niveles de ansiedad y estrés, o para regular tu sistema nervioso si estás muy alterado.")
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.customGreen)
            .cornerRadius(20)
            
            Text("Respiración Guiada")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
            
            Picker("Técnica", selection: $tecnicaSeleccionada) {
                ForEach(TecnicaRespiracion.allCases, id: \.self) { tecnica in
                    Text(tecnica.rawValue).tag(tecnica)
                }
            }
            .pickerStyle(.segmented)
            .disabled(estaActivo)
//            .padding(.horizontal)
            .preferredColorScheme(.dark)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(1.0), lineWidth: 12)
                    .frame(width: 220, height: 220)
                
                if esFaseMantener {
                    Circle()
                        .fill(colorFase.opacity(0.3))
                        .frame(width: 220, height: 220)
                    
                    Circle()
                        .stroke(colorFase, lineWidth: 12)
                        .frame(width: 220, height: 220)
                } else {
                    Circle()
                        .trim(from: 0, to: progresoAnimado)
                        .stroke(
                            colorFase,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .frame(width: 220, height: 220)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 0.05), value: progresoAnimado)
                }
                
                VStack(spacing: 8) {
                    if estaActivo {
                        Text(faseActual)
                            .font(.headline)
                            .foregroundStyle(colorFase)
                        
                        Text("\(segundosMostrados)")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .contentTransition(.numericText())
                    } else {
                        Text("Prepárate")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text("\(Int(duracionFaseActual))")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.vertical, 20)
            
            Text("Ciclos: \(repeticiones)")
                .font(.title3.bold())
                .foregroundStyle(.white)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button("Cerrar") {
                    detener()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                
                Button(estaActivo ? "Detener" : "Iniciar") {
                    if estaActivo {
                        detener()
                    } else {
                        iniciar()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(estaActivo ? .brown : Color.customGreen)
            }
            .font(.title3)
        }
        .padding()
        .background(Color.customBlue)
    }
    
    private func iniciar() {
        estaActivo = true
        pasoActual = 0
        repeticiones = 0
        progresoFase = 0
        segundosMostrados = Int(tecnicaSeleccionada.pasos[0].duracion)
        tiempoInicioFase = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            actualizarProgreso()
        }
    }
    
    private func actualizarProgreso() {
        let ahora = Date()
        let elapsed = ahora.timeIntervalSince(tiempoInicioFase)
        progresoFase = elapsed / duracionFaseActual
        
        segundosMostrados = Int(ceil(duracionFaseActual - elapsed))
        
        if elapsed >= duracionFaseActual {
            cambiarPaso()
        }
    }
    
    private func detener() {
        timer?.invalidate()
        timer = nil
        estaActivo = false
        pasoActual = 0
        progresoFase = 0
        segundosMostrados = 0
    }
    
    private func cambiarPaso() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
        if pasoActual < tecnicaSeleccionada.pasos.count - 1 {
            pasoActual += 1
        } else {
            repeticiones += 1
            pasoActual = 0
        }
        
        tiempoInicioFase = Date()
        progresoFase = 0
        segundosMostrados = Int(tecnicaSeleccionada.pasos[pasoActual].duracion)
    }
}

#Preview {
    VistaRespira()
}
