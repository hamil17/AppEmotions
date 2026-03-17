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
    @State private var respuestaEmocion: String = ""
    
    let uid: String
    var emocion:Emocion
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.235, green: 0.918, blue: 0.663))
                    .frame(height: 100)
                Text("¿Qué pensamientos tienes cuando viene o estás en esta emoción?")
                    .bold()
            }
            TextEditor(text: $respuestaEmocion)
                .padding()
                .background(.white)
                .cornerRadius(20)
                .frame(height: 300)
            
            
            Spacer()
            
            HStack{
                Button("Cerrar") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                Button("Guardar"){
                    viewModel.anadirRespuesta(
                        uid: uid,
                        texto: respuestaEmocion,
                        idEmocion: emocion.id ?? "No ID = desde el canvas"
                    )
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
        .onAppear(){
            // Carga al entrar en la vista
            viewModel.cargarRespuesta(
                uid: uid,
                idEmocion: emocion.id ?? "No ID",
                bindingTexto: $respuestaEmocion
            )
        }
    }
}

#Preview {
    VistaAnaliza(uid: "preview-uid", emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
