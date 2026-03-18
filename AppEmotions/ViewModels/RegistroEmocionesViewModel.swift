//
//  RegistroEmocionesViewModel.swift
//  AppEmotions
//
//  Created by Equipo 5 on 18/3/26.
//

import SwiftUI
import Observation
import FirebaseFirestore

@Observable
class RegistroEmocionesViewModel {
    var respuestas: [Respuesta] = []
    var emociones: [Emocion] = []
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    private func userRef(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }
    
    private func respuestasRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection("respuestas")
    }
    
    func escuchar(uid: String) {
        listener?.remove()
        respuestas.removeAll()
        
        db.collection("Emociones").getDocuments { [weak self] snapshot, error in
            self?.emociones = snapshot?.documents.compactMap { doc in
                try? doc.data(as: Emocion.self)
            } ?? []
        }
        
        listener = respuestasRef(uid: uid)
            .order(by: "fecha", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                self?.respuestas = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Respuesta.self)
                } ?? []
            }
    }
    
}
