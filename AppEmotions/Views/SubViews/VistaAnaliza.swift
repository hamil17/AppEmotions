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
            Button("Guardar"){
                viewModel.anadirRespuesta(texto: respuestaEmocion, idEmocion: emocion.id ?? "No ID = desde el canvas")
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0.235, green: 0.918, blue: 0.663))
            .foregroundStyle(.black)
            .disabled(respuestaEmocion.isEmpty)
            
            Spacer()
        }
        .padding()
        .background(Color(red: 0.208, green: 0.247, blue: 0.329))
        .onAppear(){
            // Carga al entrar en la vista
            viewModel.cargarRespuesta(idEmocion: emocion.id ?? "No ID", bindingTexto: $respuestaEmocion)
        }
    }
}

#Preview {
    VistaAnaliza(emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria"))
}
