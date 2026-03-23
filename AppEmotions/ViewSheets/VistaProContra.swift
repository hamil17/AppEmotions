//
//  VistaProContra.swift
//  AppEmotions
//
//  Created by Equipo 5 on 23/3/26.
//

import SwiftUI

struct VistaProContra: View {
    @Environment(\.dismiss) var dismiss
    @State var pros: String = ""
    @State var contras: String = ""
    @State private var situation: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Aqui puedes poner los pros y contras de esa situación que te está afectando, la ideas no es ver cual tiene mas, es intentar ver lo que no estas viendo realmente, (Spoiler: aquí muchas veces hay incoherencias, pero eso es parte del juego)")
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.customGreen)
            .cornerRadius(20)
            
            
            Form{
                Section(header: Text("¿Que situación quieres poner en la balanza?")){
                    TextEditor(text: $situation)
                        .frame(minHeight: 50)
                }
                
                HStack {
                    VStack{
                        Text("Pros")
                        TextEditor(text: $pros)
                            .padding(5)
                            .frame(minHeight: 300)
                            .background(.green.opacity(0.1))
                            .cornerRadius(20)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            .onChange(of: pros) { oldValue, newValue in
                                            if newValue.isEmpty { return }
                                            if oldValue.isEmpty { pros = "• " + newValue }
                                            if newValue.hasSuffix("\n") { pros += "• " }
                            }
                    }
                    VStack{
                        Text("Contras")
                        TextEditor(text: $contras)
                            .padding(5)
                            .frame(minHeight: 300)
                            .background(.red.opacity(0.1))
                            .cornerRadius(20)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            .onChange(of: contras) { oldValue, newValue in
                                            if newValue.isEmpty { return }
                                            if oldValue.isEmpty { contras = "• " + newValue }
                                            if newValue.hasSuffix("\n") { contras += "• " }
                            }
                        
                    }
                }
            }
            .cornerRadius(20)
            
            HStack {
                Button("Cerrar") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                Button("Guardar"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.black)
                .tint(Color(red: 0.235, green: 0.918, blue: 0.663))
                .disabled(situation.isEmpty || pros.isEmpty || contras.isEmpty)
            }
        }
        .padding()
        .background(Color.customBlue)
    }
}

#Preview {
    VistaProContra()
}
