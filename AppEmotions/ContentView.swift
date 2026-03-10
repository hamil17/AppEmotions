//
//  ContentView.swift
//  CursoiOS-AppEmociones
//
//  Created by Equipo 5 on 27/1/26.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var authManager = AuthManager()
    
    
    var body: some View {
        if authManager.user != nil {
            VistaMain()
            
        } else {
            VistaLogin(authManager: authManager)
        }
    }
}

#Preview {
//    @Previewable @State var appDataEmociones = VistaEmocionesViewModel()
    
    ContentView()
//        .environment(appDataEmociones)
        
}
