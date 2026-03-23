//
//  VistaListaProsContras.swift
//  AppEmotions
//
//  Created by Equipo 5 on 23/3/26.
//

import SwiftUI

struct VistaListaProsContras: View {
    let uid: String
    @State var viewModel = ProsContrasViewModel()
    
    var body: some View {
        List {
            if viewModel.prosContrasList.isEmpty {
                ContentUnavailableView(
                    "Sin pros y contras registrados",
                    systemImage: "scalemass",
                    description: Text("Aún no has realizado ningún análisis de pros y contras.")
                )
            } else {
                ForEach(viewModel.prosContrasList, id: \.id) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            if let emocion = viewModel.emociones.first(where: { $0.id == item.idEmocion }) {
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
                            Text(item.fecha.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Text(item.situacion)
                            .font(.headline)
                            .lineLimit(2)
                        
                        HStack(spacing: 12) {
                            VStack(alignment: .leading) {
                                Text("Pros")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.green)
                                Text(item.pros)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .leading) {
                                Text("Contras")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.red)
                                Text(item.contras)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.eliminar(uid: uid, item: item)
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle("Pros y Contras")
        .onAppear {
            viewModel.escuchar(uid: uid)
        }
    }
}

#Preview {
    NavigationStack {
        VistaListaProsContras(uid: "preview-uid")
    }
}
