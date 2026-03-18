//
//  VistaRegistroEmociones.swift
//  AppEmotions
//
//  Created by Equipo 5 on 18/3/26.
//

import SwiftUI

struct VistaRegistroEmociones: View {
    let uid: String
    @State var viewModel = EmocionesViewModel()
    
    var body: some View {
        List {
            if viewModel.respuestas.isEmpty {
                ContentUnavailableView(
                    "Sin análisis registrados",
                    systemImage: "doc.text",
                    description: Text("Aún no has realizado ningún análisis de emociones.")
                )
            } else {
                ForEach(viewModel.respuestas) { respuesta in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            if let emocion = viewModel.emociones.first(where: { $0.id == respuesta.idEmocion }) {
                                Text(emocion.nombre)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.customBlue)
                                    .foregroundStyle(.white)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                            Text(respuesta.fecha.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Text(respuesta.texto)
                            .lineLimit(3)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Registro de Emociones")
        .onAppear {
            viewModel.escucharRespuestas(uid: uid)
        }
    }
}

#Preview {
    NavigationStack {
        VistaRegistroEmociones(uid: "preview-uid")
    }
}
