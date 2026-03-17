//
//  ContentView.swift
//  CursoiOS-AppEmociones
//
//  Created by Equipo 5 on 27/1/26.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var loginViewModel = LoginViewModel()
    
    
    var body: some View {
        if let uid = loginViewModel.uid {
            VistaMain(uid: uid, loginViewModel: loginViewModel)
        } else {
            VistaLogin(loginViewModel: loginViewModel)
        }
    }
}

#Preview {
//    @Previewable @State var appDataEmociones = VistaEmocionesViewModel()
    
    ContentView()
//        .environment(appDataEmociones)
        
}
