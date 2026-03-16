//
//  AuthManager.swift
//  CursoiOS-firebase
//
//  Created by Equipo 5 on 2/3/26.
//

import Foundation
import FirebaseAuth

@Observable
class LoginViewModel {
    var user: User? // tipo de variable de firebase
    
    init() {
        // Asigna el ususrio a si hay sesión guardada
        user = Auth.auth().currentUser
    }
    
    // Función para registrar un usuario nuevo
    func register(email:String, pass: String) async throws{
        let result = try await Auth.auth().createUser(withEmail: email, password: pass)
        print("Usuario creado")
        user = result.user
    }
    
    func login (email:String, pass: String) async throws{
        let result = try await Auth.auth().signIn(withEmail: email, password: pass)
        print("Usuario logeado")
        user = result.user
    }
    
    func logout (){
        try? Auth.auth().signOut()
        user = nil
    }
    
}
