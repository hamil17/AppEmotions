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
}
