//
//  ProsContras.swift
//  AppEmotions
//
//  Created by Equipo 5 on 23/3/26.
//

import Foundation
import FirebaseFirestore

struct ProsContras: Identifiable, Codable {
    var id: String = UUID().uuidString
    
    var fecha: Date
    var situacion: String
    var pros: String
    var contras: String
    var idEmocion: String
    
    enum CodingKeys: String, CodingKey {
        case fecha, situacion, pros, contras, idEmocion
    }
    
    init(fecha: Date, situacion: String, pros: String, contras: String, idEmocion: String, id: String = UUID().uuidString) {
        self.fecha = fecha
        self.situacion = situacion
        self.pros = pros
        self.contras = contras
        self.idEmocion = idEmocion
        self.id = id
    }
}
