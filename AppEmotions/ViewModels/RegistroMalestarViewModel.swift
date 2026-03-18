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
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    private func userRef(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }
    
    private func registrosRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection("registros")
    }
    
    func escuchar(uid: String) {
        listener?.remove()
        registros.removeAll()
        
        db.collection("Emociones").getDocuments { [weak self] snapshot, error in
            self?.emociones = snapshot?.documents.compactMap { doc in
                try? doc.data(as: Emocion.self)
            } ?? []
        }
        
        listener = registrosRef(uid: uid)
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
