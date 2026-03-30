//
//  RespuestaAnalisis.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import Foundation
import FirebaseFirestore

struct Registro: Identifiable, Codable {
    var id: String = UUID().uuidString
    
    var fecha: Date
    var situacion: String
    var pensamientos: String
    var emociones: String
    var conducta: String
    var nivelMalestar: Double
    var idEmocion: String
    
    enum CodingKeys: String, CodingKey {
        case fecha, situacion, pensamientos, emociones, conducta, nivelMalestar, idEmocion
    }
    
    init(fecha: Date, situacion: String, pensamientos: String, emociones: String, conducta: String, nivelMalestar: Double, idEmocion: String, id: String = UUID().uuidString) {
        self.fecha = fecha
        self.situacion = situacion
        self.pensamientos = pensamientos
        self.emociones = emociones
        self.conducta = conducta
        self.nivelMalestar = nivelMalestar
        self.idEmocion = idEmocion
        self.id = id
    }
}
