//
//  AvatarFlotante.swift
//  AppEmotions
//
//  Created by Equipo 5 on 19/3/26.
//

import SwiftUI

struct AvatarFlotante: View {
    let tareasCompletadas: Int
    
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var showParticles: Bool = false
    
    private var nivelAvatar: Int {
        switch tareasCompletadas {
        case 0: return 0
        case 1...2: return 1
        case 3: return 2
        case 4: return 3
        default: return 4
        }
    }
    
    private var nombreImagen: String {
        "avatar_\(nivelAvatar)"
    }
    
    private var mensajeMotivacional: String {
        switch tareasCompletadas {
        case 0: return "¡Empieza tu día!"
        case 1: return "¡Buen inicio!"
        case 2: return "¡Sigue así!"
        case 3: return "¡Más de la mitad!"
        case 4: return "¡Casi lo tienes!"
        default: return "¡Día perfecto!"
        }
    }
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                if showParticles {
                    ForEach(0..<8, id: \.self) { index in
                        ParticleView(index: index)
                    }
                }
                
                Image(nombreImagen)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .scaleEffect(scale)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
            }
            
            Text(mensajeMotivacional)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.6))
                .clipShape(Capsule())
        }
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = CGSize(
                        width: lastOffset.width + value.translation.width,
                        height: lastOffset.height + value.translation.height
                    )
                }
                .onEnded { _ in
                    lastOffset = offset
                }
        )
        .onChange(of: tareasCompletadas) { _, newValue in
            if newValue > 0 {
                triggerCelebration()
            }
        }
    }
    
    private func triggerCelebration() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            scale = 1.3
        }
        
        showParticles = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                scale = 1.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showParticles = false
        }
    }
}

struct ParticleView: View {
    let index: Int
    
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 0.5
    @State private var offset: CGFloat = 0
    
    var body: some View {
        let angle = Double(index) * 45.0
        let radians = angle * .pi / 180.0
        
        Image(systemName: "star.fill")
            .font(.system(size: 12))
            .foregroundStyle(.yellow)
            .offset(x: cos(radians) * 50 + offset, y: sin(radians) * 50 - 20)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    scale = 1.5
                    offset = 20
                    opacity = 0
                }
            }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.3)
            .ignoresSafeArea()
        AvatarFlotante(tareasCompletadas: 4)
    }
}
