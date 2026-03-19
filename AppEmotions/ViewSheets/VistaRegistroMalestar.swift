//
//  VistaRegistroMalestar.swift
//  AppEmotions
//
//  Created by Equipo 5 on 13/3/26.
//

import SwiftUI

struct VistaRegistroMalestar: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel = EmocionesViewModel()
    @State private var dailyStats = DailyStatsViewModel()
    
    @State private var fecha: Date = Date()
    @State private var situacion: String = ""
    @State private var pensamientos: String = ""
    @State private var emociones: String = ""
    @State private var conducta: String = ""
    @State private var nivelMalestar: Double = 0.0
    
    let uid: String
    var emocion:Emocion
    var registroExistente: Registro?
    
    private var esEdicion: Bool { registroExistente != nil }
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.235, green: 0.918, blue: 0.663).gradient)
                    .frame(height: 100)
                Text(esEdicion ? "Editando registro de malestar" : "Este registro se usa para que puedas reflexionar sobre tus emociones y cómo te sientes en diferentes situaciones.")
                    .bold()
                    .padding()
            }
            Form{
                DatePicker("Fecha y hora", selection: $fecha)
                    .foregroundStyle(.secondary)
                Section(header: Text("Situación: ¿Donde estás? / ¿Qué estás haciendo?")){
                    TextEditor(text: $situacion)
                        .frame(minHeight: 60
                        )
                }
                Section(header: Text("Pensamientos: Qué se te ha venido a la cabeza (recuerdos, pensamientos, ideas, imágenes, etc.)")
                                
                    ) {
                        TextEditor(text: $pensamientos)
                            .frame(minHeight: 60)
                }
                Section(header: Text("Emoción(es): Qué emoción sientes (ira, tristeza, ansiedad, miedo, etc. Si no sabes qué sientes, puedes describir lo que estas sintiendo)")
                                
                    ) {
                        TextEditor(text: $emociones)
                            .frame(minHeight: 60)
                }
                Section(header: Text("Conducta: ¿Qué haces en consecuencia a la situación?")
                                
                    ) {
                        TextEditor(text: $conducta)
                            .frame(minHeight: 60)
                }
                Section(header: Text("¿Cual es tu nivel de malestar? =  \(Int(nivelMalestar))")
                                
                    ) {
                    Slider(value: $nivelMalestar, in: 1...10, step: 1){
                    }
                }
                
                
            }
            .cornerRadius(40)
            HStack{
                Button("Cancelar") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                Button(esEdicion ? "Guardar cambios" : "Guardar") {
                    if esEdicion, let registro = registroExistente {
                        let registroActualizado = Registro(
                            fecha: fecha,
                            situacion: situacion,
                            pensamientos: pensamientos,
                            emociones: emociones,
                            conducta: conducta,
                            nivelMalestar: nivelMalestar,
                            idEmocion: registro.idEmocion
                        )
                        registroActualizado.id = registro.id
                        RegistroMalestarViewModel().actualizarRegistro(uid: uid, registro: registroActualizado)
                    } else {
                        viewModel.anadirRegistro(
                            uid: uid,
                            fecha: fecha,
                            situacion: situacion,
                            pensamientos: pensamientos,
                            emociones: emociones,
                            conducta: conducta,
                            nivelMalestar: nivelMalestar,
                            idEmocion: emocion.id ?? "No ID = desde el canvas"
                        )
                        dailyStats.markTask(uid: uid, task: .didRegisterMalestar)
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.black)
                .tint(Color(red: 0.235, green: 0.918, blue: 0.663))
                .disabled(situacion.isEmpty || pensamientos.isEmpty || emociones.isEmpty || conducta.isEmpty)
            }
            
        }
        .padding()
        .background(Color.customBlue)
        .onAppear {
            if let registro = registroExistente {
                fecha = registro.fecha
                situacion = registro.situacion
                pensamientos = registro.pensamientos
                emociones = registro.emociones
                conducta = registro.conducta
                nivelMalestar = registro.nivelMalestar
            }
        }
    }
}

#Preview {
    VistaRegistroMalestar(uid: "preview-uid", emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
