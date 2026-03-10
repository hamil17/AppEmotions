//
//  File.swift
//  AppEmotions
//
//  Created by Equipo 5 on 6/3/26.
//

import SwiftUI
import FirebaseFirestore

struct Emocion: Identifiable, Codable {
    @DocumentID var id: String?
    
    var nombre: String
    var descripcion: String
    var color: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id, nombre, descripcion, color, image
    }
}

extension Color {
    static func fromString(_ name : String) -> Color {
        switch name {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "yellow":
            return .yellow
        default:
            return .gray
        }
    }
}
