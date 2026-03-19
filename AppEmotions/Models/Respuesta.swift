//
//  RespuestaAnalisis.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import Foundation
import FirebaseFirestore

struct Respuesta: Identifiable, Codable {
    var id: String = UUID().uuidString
    var texto: String
    var idEmocion: String
    var fecha: Date
    
    enum CodingKeys: String, CodingKey {
        case texto, idEmocion, fecha
    }
    
    init(texto: String, idEmocion: String, fecha: Date) {
        self.texto = texto
        self.idEmocion = idEmocion
        self.fecha = fecha
    }
}
