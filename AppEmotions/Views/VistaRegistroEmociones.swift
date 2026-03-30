//
//  VistaRegistroEmociones.swift
//  AppEmotions
//
//  Created by Equipo 5 on 18/3/26.
//

import SwiftUI

struct VistaRegistroEmociones: View {
    let uid: String
    @State var viewModel = RegistroEmocionesViewModel()
    
    var body: some View {
        List {
            if viewModel.respuestas.isEmpty {
                ContentUnavailableView(
                    "Sin análisis registrados",
                    systemImage: "doc.text",
                    description: Text("Aún no has realizado ningún análisis de emociones.")
                )
            } else {
                ForEach(viewModel.respuestas, id: \.id) { respuesta in
                    NavigationLink {
                        VistaAnaliza(uid: uid, emocion: Emocion(nombre: "", descripcion: "", color: "", image: "", sonido: ""), respuestaExistente: respuesta)
                    } label: {
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
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.eliminarRespuesta(uid: uid, respuesta: respuesta)
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle("Registro de Emociones")
        .onAppear {
            viewModel.escuchar(uid: uid)
        }
    }
}

#Preview {
    NavigationStack {
        VistaRegistroEmociones(uid: "preview-uid")
    }
}
