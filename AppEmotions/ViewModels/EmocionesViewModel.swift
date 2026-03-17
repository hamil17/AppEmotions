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
    static let coleccionRegistros = "registros"
}

@Observable
class EmocionesViewModel {
    
    
    var emociones: [Emocion] = []
    var respuestas: [Respuesta] = []
    
    private var db = Firestore.firestore()
    
    init(){
        escucharDatos()
    }

    private func userRef(uid: String) -> DocumentReference {
        db.collection("users").document(uid)
    }
    
    private func respuestasRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection(ConstantesFirestore.coleccionRespuestas)
    }
    
    private func registrosRef(uid: String) -> CollectionReference {
        userRef(uid: uid).collection(ConstantesFirestore.coleccionRegistros)
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
    
    func cargarRespuesta(uid: String, idEmocion: String, bindingTexto: Binding<String>) {
        let docRef = respuestasRef(uid: uid).document(idEmocion)
        
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
    
    func anadirRespuesta(uid: String, texto: String, idEmocion: String) {
        
        // 1. Referencia al documento fijo para esa emoción
        let docRef = respuestasRef(uid: uid).document(idEmocion)
        
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
    
    func anadirRegistro(uid: String, fecha: Date, situacion:String,pensamientos:String, emociones:String, conducta:String, nivelMalestar:Double, idEmocion:String){
        let docRef = registrosRef(uid: uid)
        
        let nuevoRegistro = Registro(fecha: fecha,
                                     situacion: situacion,
                                     pensamientos: pensamientos,
                                     emociones: emociones,
                                     conducta: conducta,
                                     nivelMalestar: nivelMalestar,
                                     idEmocion: idEmocion)
        
        
        do {
            try docRef.addDocument(from: nuevoRegistro)
        } catch {
            print("Error guardado: \(error)")
        }
    }

    
}


