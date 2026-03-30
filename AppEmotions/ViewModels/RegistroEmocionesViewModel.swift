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
    var isLoading = true
    
    private var db = Firestore.firestore()
    private var listenerRespuestas: ListenerRegistration?
    private var listenerEmociones: ListenerRegistration?
    
    private static let ordenEmociones = ["Alegría", "Tristeza", "Miedo", "Ira", "Asco"]
    
    private func userRef(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }
    
    private func respuestasRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection("respuestas")
    }
    
    func escuchar(uid: String) {
        listenerRespuestas?.remove()
        respuestas.removeAll()
        
        listenerEmociones = db.collection("Emociones")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                let mapped = snapshot?.documents.compactMap { doc -> Emocion? in
                    try? doc.data(as: Emocion.self)
                } ?? []
                self.emociones = mapped.sorted { e1, e2 in
                    let i1 = Self.ordenEmociones.firstIndex(of: e1.nombre) ?? Int.max
                    let i2 = Self.ordenEmociones.firstIndex(of: e2.nombre) ?? Int.max
                    return i1 < i2
                }
                self.isLoading = false
                
                self.cargarRespuestas(uid: uid)
            }
    }
    
    private func cargarRespuestas(uid: String) {
        listenerRespuestas?.remove()
        listenerRespuestas = respuestasRef(uid: uid)
            .order(by: "fecha", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                if let results = snapshot?.documents.compactMap({ doc -> Respuesta? in
                    guard var respuesta = try? doc.data(as: Respuesta.self) else { return nil }
                    respuesta.id = doc.documentID
                    return respuesta
                }) {
                    self?.respuestas = results
                }
            }
    }
    
    func actualizarRespuesta(uid: String, respuesta: Respuesta) {
        let docRef = respuestasRef(uid: uid).document(respuesta.id)
        let data: [String: Any] = [
            "texto": respuesta.texto,
            "idEmocion": respuesta.idEmocion,
            "fecha": Timestamp(date: respuesta.fecha)
        ]
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error actualizando respuesta: \(error)")
            } else {
                print("Respuesta actualizada correctamente")
            }
        }
    }
    
    func eliminarRespuesta(uid: String, respuesta: Respuesta) {
        respuestasRef(uid: uid).document(respuesta.id).delete { error in
            if let error = error {
                print("Error eliminando respuesta: \(error)")
            } else {
                print("Respuesta eliminada correctamente")
            }
        }
    }
}
