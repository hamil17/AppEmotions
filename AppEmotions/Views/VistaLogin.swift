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
        VStack(spacing: 30) {
            VStack(){
                Image("imgMain")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 550)
            .background(
                WaveShape(waveHeight: 15, phase: .zero)
                    .fill(Color.customGreen) // Tu color de fondo
                    .shadow(radius: 5)
            )
            
            
          
            VStack(alignment: .leading){
                Text(seEstaRegistrando ? "Crear cuenta" : "Bienvenido/a")
                    .font(.largeTitle)
                    .foregroundStyle(Color.customBlue)
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
                
                
                
                
                
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack{
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
                        .background(Color.customBlue)
                        .foregroundStyle(.white)
                        .bold()
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
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 120)
        }
        .ignoresSafeArea()
        .background(.gray.opacity(0.3))
        
        
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

struct WaveShape: Shape {
    var waveHeight: CGFloat // Qué tan profunda es la onda
    var phase: Angle        // Para animarla si quieres

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero) // Esquina superior izquierda
        path.addLine(to: CGPoint(x: rect.width, y: 0)) // Superior derecha
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - waveHeight)) // Lateral derecho
        
        // Dibujamos la onda en la base
        for x in stride(from: rect.width, through: 0, by: -1) {
            let relativeX = x / rect.width
            let sine = sin(relativeX * .pi * 2 + CGFloat(phase.radians))
            let y = rect.height - waveHeight - (sine * waveHeight)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    VistaLogin(loginViewModel: LoginViewModel())
}
