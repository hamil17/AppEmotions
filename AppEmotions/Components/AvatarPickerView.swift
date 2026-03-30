//
//  AvatarPickerView.swift
//  AppEmotions
//
//  Created by Equipo 5 on 23/3/26.
//

import SwiftUI

struct AvatarPickerView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedAvatarModel") private var selectedModel: Int = 0
    
    private let modelCount = 4
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Selecciona un modelo de avatar")
                    .font(.headline)
                    .padding(.top)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(0..<modelCount, id: \.self) { model in
                        Button {
                            selectedModel = model
                            dismiss()
                        } label: {
                            Image("avatar_\(model)_0")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 100)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedModel == model ? Color.customBlue : Color.clear, lineWidth: 3)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Cambiar Avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AvatarPickerView()
}
