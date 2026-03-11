//
//  VistaEjercita.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import SwiftUI

struct VistaAnaliza: View {
//    var viewModel : VistaEmocionesViewModel
    @State private var respuestaEmocion: String = ""
    
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
//                viewModel.respuestas
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .background(Color(red: 0.208, green: 0.247, blue: 0.329))
    }
}

#Preview {
    VistaAnaliza()
}
