import SwiftUI
import AVKit
import AVFoundation

struct VistaMedita: View {
    @Environment(\.dismiss) var dismiss
    @State var reproductor = ReproductorViewModel()
    
    var emocion:Emocion
    
    // URL ejemplo de música relax gratuita (Free Music Archive)
    let urlMusica: URL
//    let urlMusica = URL(string: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/jQ4du0HGj6kB3A7I0CkL8Y8AfymQOK9V4zMVgfDl.mp3")!
    
    init(emocion: Emocion) {
        self.emocion = emocion
        urlMusica = URL(string: emocion.sonido)!
    }
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.235, green: 0.918, blue: 0.663))
                    .frame(height: 100)
                Text("Esta musica puede ayudarte a conectar con tu emoción y hace que la transites")
                    .padding()
                    .bold()
            }
            // Controles del reproductor
            HStack {
                Button{
                    reproductor.togglePlayPause()
                } label: {
                    if reproductor.isPlaying {
                        Image("iconPause")
                    } else {
                        Image("iconPlay")
                    }
                }
            }
            
            // Barra de progreso (opcional)
            ProgressView(value: reproductor.progreso)
                .frame(height: 8)
                .padding(.horizontal)
            
            Spacer()
            
            Button("Cerrar") {
                reproductor.stop()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.black)
        }
        .padding()
        .background(Color(red: 0.208, green: 0.247, blue: 0.329))
        .onAppear {
            print("URL música: \(urlMusica)")
            reproductor.setup(url: urlMusica)
        }
        .onDisappear {
            reproductor.stop()
        }
    }
}

#Preview {
    VistaMedita(emocion: Emocion(nombre: "Alegría", descripcion: "Esto es una emoción de prueba para ver cómo se ve en pantalla, y hasta cambiar su color o hasta donde llega su altura, y si se puede hacer clic en ella para que cambie de color", color: "yellow", image: "Alegria", sonido: "https://files.freemusicarchive.org/storage-freemusicarchive-org/tracks/O79ZY14E9GATF7Sz92LcG7KN6HKcYODhku3yPmiz.mp3"))
}
