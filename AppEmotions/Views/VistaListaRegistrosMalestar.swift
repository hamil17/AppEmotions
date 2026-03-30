//
//  VistaListaRegistrosMalestar.swift
//  AppEmotions
//
//  Created by Equipo 5 on 18/3/26.
//

import SwiftUI

struct VistaListaRegistrosMalestar: View {
    let uid: String
    @State var viewModel = RegistroMalestarViewModel()
    
    var body: some View {
        List {
            if viewModel.registros.isEmpty {
                ContentUnavailableView(
                    "Sin registros de malestar",
                    systemImage: "heart.slash",
                    description: Text("Aún no has registrado ningún malestar.")
                )
            } else {
                ForEach(viewModel.registros, id: \.id) { registro in
                    NavigationLink {
                        VistaRegistroMalestar(uid: uid, emocion: Emocion(nombre: "", descripcion: "", color: "", image: "", sonido: ""), registroExistente: registro)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                if let emocion = viewModel.emociones.first(where: { $0.id == registro.idEmocion }) {
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
                                Text(registro.fecha.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundStyle(.orange)
                                Text("Malestar: \(Int(registro.nivelMalestar))/10")
                                    .font(.subheadline)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Label(registro.situacion, systemImage: "location")
                                    .lineLimit(2)
                                    .font(.caption)
                                Label(registro.pensamientos, systemImage: "brain.head.profile")
                                    .lineLimit(2)
                                    .font(.caption)
                                Label(registro.emociones, systemImage: "heart")
                                    .lineLimit(2)
                                    .font(.caption)
                                Label(registro.conducta, systemImage: "figure.walk")
                                    .lineLimit(2)
                                    .font(.caption)
                            }
                            .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.eliminarRegistro(uid: uid, registro: registro)
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle("Registros de Malestar")
        .onAppear {
            viewModel.escuchar(uid: uid)
        }
    }
}

#Preview {
    NavigationStack {
        VistaListaRegistrosMalestar(uid: "preview-uid")
    }
}
