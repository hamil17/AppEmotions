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
    var registros: [Registro] = []
    
    private var db = Firestore.firestore()
    private var listenerRespuestas: ListenerRegistration?
    private var listenerRegistros: ListenerRegistration?
    
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
    
    private static let ordenEmociones = ["Alegría", "Tristeza", "Miedo", "Ira", "Asco"]
    
    func escucharDatos(){
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
                let mapped = documents.compactMap { doc -> Emocion? in
                    do {
                        return try doc.data(as: Emocion.self)
                    } catch {
                        print("Error al mapear: \(error.localizedDescription)")
                        return nil
                    }
                }
                self.emociones = mapped.sorted { e1, e2 in
                    let i1 = Self.ordenEmociones.firstIndex(of: e1.nombre) ?? Int.max
                    let i2 = Self.ordenEmociones.firstIndex(of: e2.nombre) ?? Int.max
                    return i1 < i2
                }
                print(self.emociones.count)
            }
    }
    
    func cargarRespuesta(uid: String, idEmocion: String, bindingTexto: Binding<String>) {
        respuestasRef(uid: uid)
            .whereField("idEmocion", isEqualTo: idEmocion)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error cargando respuesta: \(error)")
                    return
                }
                
                guard let doc = snapshot?.documents.last else {
                    bindingTexto.wrappedValue = ""
                    return
                }
                let data = doc.data()
                let textoGuardado = data["texto"] as? String
                bindingTexto.wrappedValue = textoGuardado ?? ""
            }
    }
    
    func anadirRespuesta(uid: String, texto: String, idEmocion: String) {
        let docRef = respuestasRef(uid: uid)
        
        let nuevaRespuesta = Respuesta(texto: texto, idEmocion: idEmocion, fecha: Date())
        
        print("Guardando respuesta para uid: \(uid), emocion: \(idEmocion)")
        
        do {
            try docRef.addDocument(from: nuevaRespuesta)
            print("Respuesta guardada exitosamente")
        } catch {
            print("Error al guardar respuesta: \(error)")
        }
    }
    
    func escucharRespuestas(uid: String) {
        listenerRespuestas?.remove()
        respuestas.removeAll()
        listenerRespuestas = respuestasRef(uid: uid)
            .order(by: "fecha", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error cargando respuestas: \(error)")
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
    
    func escucharRegistros(uid: String) {
        listenerRegistros?.remove()
        registros.removeAll()
        listenerRegistros = registrosRef(uid: uid)
            .order(by: "fecha", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error cargando registros: \(error)")
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


