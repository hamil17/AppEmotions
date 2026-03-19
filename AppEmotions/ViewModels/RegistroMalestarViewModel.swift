//
//  RegistroMalestarViewModel.swift
//  AppEmotions
//
//  Created by Equipo 5 on 18/3/26.
//

import SwiftUI
import Observation
import FirebaseFirestore

@Observable
class RegistroMalestarViewModel {
    var registros: [Registro] = []
    var emociones: [Emocion] = []
    var isLoading = true
    
    private var db = Firestore.firestore()
    private var listenerRegistros: ListenerRegistration?
    private var listenerEmociones: ListenerRegistration?
    
    private func userRef(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }
    
    private func registrosRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection("registros")
    }
    
    func escuchar(uid: String) {
        listenerRegistros?.remove()
        registros.removeAll()
        
        listenerEmociones = db.collection("Emociones")
            .addSnapshotListener { [weak self] snapshot, error in
                self?.emociones = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Emocion.self)
                } ?? []
                self?.isLoading = false
                
                self?.cargarRegistros(uid: uid)
            }
    }
    
    private func cargarRegistros(uid: String) {
        listenerRegistros?.remove()
        listenerRegistros = registrosRef(uid: uid)
            .order(by: "fecha", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                self?.registros = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Registro.self)
                } ?? []
            }
    }
}
