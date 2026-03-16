//
//  VistaLogin.swift
//  CursoiOS-firebase
//
//  Created by Equipo 5 on 2/3/26.
//

import SwiftUI

struct VistaLogin: View {
    @Bindable var loginViewModel : LoginViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var seEstaRegistrando = false // ¿Registrando o haciendo login?
    @State private var logeando = false
    @State private var mensajeError : String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(seEstaRegistrando ? "Crear cuenta" : "Bienvenido/a")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            
            SecureField("Contraseña", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if let mensajeError {
                Text(mensajeError)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            
            // Botón de inicio de sesión o registro
            Button{
                logeando = true
                Task {
                    await autenticar()
                }
            } label: {
                Text(seEstaRegistrando ? "Registrarse" : "Iniciar sesión")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .disabled(email.isEmpty || password.isEmpty || logeando)
            .opacity(email.isEmpty || password.isEmpty || logeando ? 0.5 : 1.0)
            
            // Botón para cambiar a registro o a inicio de sesión, tiene apariencia de enlace
            Button {
                seEstaRegistrando.toggle()
                mensajeError = nil
            } label: {
                Text(seEstaRegistrando ? "¿Ya tienes una cuenta? ¡Entra!" : "¿No tienes cuenta? ¡Registrate!")
                    .foregroundStyle(.blue)
            }
        }
        .padding()
    }
    
    func autenticar() async {
        do{
            if seEstaRegistrando{
                try await loginViewModel.register(email: email, pass: password)
            }else{
                try await loginViewModel.login(email: email, pass: password)
            }
            logeando = false
        } catch {
            mensajeError = error.localizedDescription
            logeando = false
        }
    }
}

//#Preview {
//    @Bindable var authManager : AuthManager
//    VistaLogin(authManager)
//}
