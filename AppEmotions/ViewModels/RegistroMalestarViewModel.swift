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
    
    private static let ordenEmociones = ["Alegría", "Tristeza", "Miedo", "Ira", "Asco"]
    
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
                
                self.cargarRegistros(uid: uid)
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
                if let results = snapshot?.documents.compactMap({ doc -> Registro? in
                    guard var registro = try? doc.data(as: Registro.self) else { return nil }
                    registro.id = doc.documentID
                    return registro
                }) {
                    self?.registros = results
                }
            }
    }
    
    func actualizarRegistro(uid: String, registro: Registro) {
        let docRef = registrosRef(uid: uid).document(registro.id)
        let data: [String: Any] = [
            "fecha": Timestamp(date: registro.fecha),
            "situacion": registro.situacion,
            "pensamientos": registro.pensamientos,
            "emociones": registro.emociones,
            "conducta": registro.conducta,
            "nivelMalestar": registro.nivelMalestar,
            "idEmocion": registro.idEmocion
        ]
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error actualizando registro: \(error)")
            } else {
                print("Registro actualizado correctamente")
            }
        }
    }
    
    func eliminarRegistro(uid: String, registro: Registro) {
        registrosRef(uid: uid).document(registro.id).delete { error in
            if let error = error {
                print("Error eliminando registro: \(error)")
            } else {
                print("Registro eliminado correctamente")
            }
        }
    }
}
