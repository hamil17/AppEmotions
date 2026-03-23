//
//  ProsContrasViewModel.swift
//  AppEmotions
//
//  Created by Equipo 5 on 23/3/26.
//

import SwiftUI
import Observation
import FirebaseFirestore

@Observable
class ProsContrasViewModel {
    var prosContrasList: [ProsContras] = []
    var emociones: [Emocion] = []
    var isLoading = true
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private var listenerEmociones: ListenerRegistration?
    
    private static let ordenEmociones = ["Alegría", "Tristeza", "Miedo", "Ira", "Asco"]
    
    private func userRef(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }
    
    private func prosContrasRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection("prosContras")
    }
    
    func escuchar(uid: String) {
        listener?.remove()
        prosContrasList.removeAll()
        
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
                
                self.cargarProsContras(uid: uid)
            }
    }
    
    private func cargarProsContras(uid: String) {
        listener?.remove()
        listener = prosContrasRef(uid: uid)
            .order(by: "fecha", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                if let results = snapshot?.documents.compactMap({ doc -> ProsContras? in
                    guard var item = try? doc.data(as: ProsContras.self) else { return nil }
                    item.id = doc.documentID
                    return item
                }) {
                    self?.prosContrasList = results
                }
                self?.isLoading = false
            }
    }
    
    func guardar(uid: String, situacion: String, pros: String, contras: String, idEmocion: String) {
        let nuevo = ProsContras(
            fecha: Date(),
            situacion: situacion,
            pros: pros,
            contras: contras,
            idEmocion: idEmocion
        )
        
        prosContrasRef(uid: uid).document(nuevo.id).setData([
            "fecha": Timestamp(date: nuevo.fecha),
            "situacion": nuevo.situacion,
            "pros": nuevo.pros,
            "contras": nuevo.contras,
            "idEmocion": nuevo.idEmocion
        ]) { error in
            if let error = error {
                print("Error guardando ProsContras: \(error)")
            } else {
                print("ProsContras guardado correctamente")
            }
        }
    }
    
    func eliminar(uid: String, item: ProsContras) {
        prosContrasRef(uid: uid).document(item.id).delete { error in
            if let error = error {
                print("Error eliminando ProsContras: \(error)")
            } else {
                print("ProsContras eliminado correctamente")
            }
        }
    }
    
    func actualizar(uid: String, item: ProsContras) {
        let docRef = prosContrasRef(uid: uid).document(item.id)
        let data: [String: Any] = [
            "situacion": item.situacion,
            "pros": item.pros,
            "contras": item.contras,
            "idEmocion": item.idEmocion
        ]
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error actualizando ProsContras: \(error)")
            } else {
                print("ProsContras actualizado correctamente")
            }
        }
    }
}
