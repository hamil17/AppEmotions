//
//  ReproductorViewModel.swift
//  AppEmotions
//
//  Created by Equipo 5 on 12/3/26.
//
import Foundation
import Observation
import AVKit
import AVFoundation


@Observable
class ReproductorViewModel {
    private var player: AVPlayer?
    var isPlaying = false
    var progreso: Double = 0
    
    func setup(url: URL) {
        player = AVPlayer(url: url)
//        player?.play()
//        isPlaying = true
        
        // Timer para progreso
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let player = self.player,
               let duration = player.currentItem?.duration.seconds,
               duration > 0 {
                self.progreso = player.currentTime().seconds / duration
            }
        }
    }
    
    func togglePlayPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: .zero)
        isPlaying = false
        progreso = 0
    }
}

