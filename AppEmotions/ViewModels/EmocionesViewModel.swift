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
    
    func cargarRespuesta(idEmocion: String, bindingTexto: Binding<String>) {
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
    
    func anadirRegistro(fecha: Date, situacion:String,pensamientos:String, emociones:String, conducta:String, nivelMalestar:Double, idEmocion:String){
        let docRef = db.collection(ConstantesFirestore.coleccionRegistros)
        
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


