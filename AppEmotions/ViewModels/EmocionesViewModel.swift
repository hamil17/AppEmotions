//
//  AppDataEmociones.swift
//  AppEmotions
//
//  Created by Equipo 5 on 6/3/26.
//

import SwiftUI
import Observation
import FirebaseFirestore

enum ConstantesFirestore {
    static let coleccionEmociones = "Emociones"
    static let coleccionRespuestas = "respuestas"
}

@Observable
class EmocionesViewModel {
    
    
    var emociones: [Emocion] = []
    var respuestas: [Respuesta] = []
    
    private var db = Firestore.firestore()
    
    init(){
        escucharDatos()
    }
    
    func escucharDatos(){
        // Consulta a "Emociones" en Firestore,  usando el idUsuario
        db.collection(ConstantesFirestore.coleccionEmociones)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error Firestore: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("Snapshot vacío o nil")
                    return
                }
                // Mapeo: del documento firestore al array de Gastos
                self.emociones = documents.compactMap { doc -> Emocion? in
                    do {
                        return try doc.data(as: Emocion.self)
                    } catch {
                        print("Error al mapear: \(error.localizedDescription)")
                        return nil
                    }
                }
                print(self.emociones.count)
            }
    }
    
//    func anadirRespuesta(texto: String, idEmocion: String) {
//        let nuevaRespuesta = Respuesta(texto: texto,
//                                       idEmocion: idEmocion)
//        do {
//            try
//                db.collection(ConstantesFirestore.coleccionRespuestas)
////                .whereField(Respuesta.CodingKeys.idEmocion.rawValue, isEqualTo: idEmocion)
//                .addDocument(from: nuevaRespuesta)
//        } catch {
//            print("Error guardado: \(error)")
//        }
//    }
    
    func cargarRespuesta(idEmocion: String, bindingTexto: Binding<String>) {
        let db = Firestore.firestore()
        let docRef = db.collection(ConstantesFirestore.coleccionRespuestas)
            .document(idEmocion)
        
        // Listener en tiempo real: carga inicial + cambios futuros
        docRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error cargando respuesta: \(error)")
                return
            }
            
            guard let data = snapshot?.data(),
                  let textoGuardado = data["texto"] as? String else {
                bindingTexto.wrappedValue = ""  // No existe, limpia
                return
            }
            
            bindingTexto.wrappedValue = textoGuardado  // Carga el texto
        }
    }
    
    func anadirRespuesta(texto: String, idEmocion: String) {
        let db = Firestore.firestore()
        
        // 1. Referencia al documento fijo para esa emoción
        let docRef = db.collection(ConstantesFirestore.coleccionRespuestas)
            .document(idEmocion)
        
        // 2. Datos a guardar (ejemplo sencillo)
        let data: [String: Any] = [
            "idEmocion": idEmocion,
            "texto": texto,
            "fecha": Timestamp(date: Date())
        ]
        
        // 3. setData => crea si no existe, actualiza si existe
        docRef.setData(data, merge: true) { error in
            if let error = error {
                print("Error al guardar respuesta: \(error)")
            } else {
                print("Respuesta guardada/actualizada correctamente")
            }
        }
    }

    
}


