//
//  VistaRegistroMalestar.swift
//  AppEmotions
//
//  Created by Equipo 5 on 13/3/26.
//

import SwiftUI

struct VistaRegistroMalestar: View {
    @Environment(\.dismiss) var dismiss
    @State private var fecha: Date = Date()
    @State private var situacion: String = ""
    @State private var pensamientos: String = ""
    @State private var emociones: String = ""
    @State private var conducta: String = ""
    @State private var nivelMalestar: Double = 0.0
    
    var body: some View {
        VStack{
            Form{
                DatePicker("Fecha y hora", selection: $fecha)
                ZStack(alignment: .leading) {
                    if situacion.isEmpty {
                        Text("Situación: ¿Donde estás? / ¿Qué estás haciendo?")
                            .foregroundStyle(.secondary)
                    }
                    TextEditor(text: $situacion)
                }
                ZStack(alignment: .leading) {
                    if pensamientos.isEmpty {
                        Text("Pensamientos: Qué se te ha venido a la cabeza(recuerdos, pensamientos, ideas, imágenes, etc.)")
                            .foregroundStyle(.secondary)
                    }
                    TextEditor(text: $pensamientos)
                }
                ZStack(alignment: .leading) {
                    if emociones.isEmpty {
                        Text("Emoción(es): Qué emoción sientes (ira, tristeza, ansiedad, miedo, etc. Si no sabes qué sientes, puedes describir lo que estas sintiendo)")
                            .foregroundStyle(.secondary)
                    }
                    TextEditor(text: $emociones)
                }
                ZStack(alignment: .leading) {
                    if conducta.isEmpty {
                        Text("Conducta: ¿Qué haces en consecuencia a la situación?")
                            .foregroundStyle(.secondary)
                    }
                    TextEditor(text: $conducta)
                }
                VStack{
                    Text("¿Cual es tu nivel de malestar? =  \(Int(nivelMalestar))")
                    Slider(value: $nivelMalestar, in: 1...10, step: 1){
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .cornerRadius(20)
            Button("Cerrar") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.black)
        }
        .padding()
        .background(Color(red: 0.208, green: 0.247, blue: 0.329))
    }
}

#Preview {
    VistaRegistroMalestar()
}
