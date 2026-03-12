//
//  File.swift
//  AppEmotions
//
//  Created by Equipo 5 on 6/3/26.
//

import Foundation
import FirebaseFirestore

struct Emocion: Identifiable, Codable {
    @DocumentID var id: String?
    
    var nombre: String
    var descripcion: String
    var color: String
    var image: String
    var sonido: String
    
    enum CodingKeys: String, CodingKey {
        case id, nombre, descripcion, color, image, sonido
    }
}
