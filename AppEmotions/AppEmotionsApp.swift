//
//  AppEmotionsApp.swift
//  AppEmotions
//
//  Created by Equipo 5 on 5/3/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    print("🔥 Firebase configurado correctamente")

    return true
  }
}

@main
struct AppEmotionsApp: App {
//    @State private var appDataEmotions = VistaEmocionesViewModel()
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(appDataEmotions)
        }
    }
}
