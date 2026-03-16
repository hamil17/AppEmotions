//
//  RespuestaAnalisis.swift
//  AppEmotions
//
//  Created by Equipo 5 on 11/3/26.
//

import Foundation
import FirebaseFirestore

struct Respuesta: Identifiable, Codable {
    @DocumentID var id: String?
    
    var texto: String
    var idEmocion: String
    
    enum CodingKeys: String, CodingKey {
        case texto, idEmocion
    }
}
