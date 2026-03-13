//
//  AppEmotionsApp.swift
//  AppEmotions
//
//  Created by Equipo 5 on 5/3/26.
//

import SwiftUI
import FirebaseCore
import AVFoundation

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
    
    init() {
        configurarAudio()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(appDataEmotions)
        }
    }
}

func configurarAudio() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try AVAudioSession.sharedInstance().setActive(true)
    } catch {
        print("Error configurando AVAudioSession: \(error)")
    }
}
