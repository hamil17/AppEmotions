//
//  VistaEjercita.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import SwiftUI

struct VistaAnaliza: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel = EmocionesViewModel()
    @State private var dailyStats = DailyStatsViewModel()
    @State private var respuestaEmocion: String = ""
    
    let uid: String
    var emocion:Emocion
    var respuestaExistente: Respuesta?
    
    private var esEdicion: Bool { respuestaExistente != nil }
    
    var body: some View {
        VStack{
            VStack {
                Text(esEdicion ? "Editando análisis" : "¿Qué pensamientos o sensaciones tienes cuando estás en esta emoción, sabrías explicarlo con palabras?")
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.customGreen)
            .cornerRadius(20)
            TextEditor(text: $respuestaEmocion)
                .padding()
                .background(.white)
                .cornerRadius(20)
                .frame(height: 300)
            
            
            Spacer()
            
            HStack{
                Button("Cancelar") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                Button(esEdicion ? "Guardar cambios" : "Guardar"){
                    if esEdicion, let respuesta = respuestaExistente {
                        let respuestaActualizada = Respuesta(
                            texto: respuestaEmocion,
                            idEmocion: respuesta.idEmocion,
                            fecha: Date(),
                            id: respuesta.id
                        )
                        RegistroEmocionesViewModel().actualizarRespuesta(uid: uid, respuesta: respuestaActualizada)
                    } else {
                        viewModel.anadirRespuesta(
                            uid: uid,
                            texto: respuestaEmocion,
                            idEmocion: emocion.id ?? "No ID = desde el canvas"
                        )
                        dailyStats.markTask(uid: uid, task: .didAnalyze)
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.235, green: 0.918, blue: 0.663))
                .foregroundStyle(.black)
                .disabled(respuestaEmocion.isEmpty)
            }
            
        }
        .padding()
        .background(Color.customBlue)
        .overlay(alignment: .bottomTrailing) {
            AvatarFlotante(tareasCompletadas: dailyStats.todayTasksCompleted)
                .padding()
        }
        .onAppear(){
            dailyStats.listenToday(uid: uid)
            if let respuesta = respuestaExistente {
                respuestaEmocion = respuesta.texto
            } else {
                viewModel.cargarRespuesta(
                    uid: uid,
                    idEmocion: emocion.id ?? "No ID",
                    bindingTexto: $respuestaEmocion
                )
            }
        }
    }
}

#Preview {
    VistaAnaliza(uid: "preview-uid", emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
