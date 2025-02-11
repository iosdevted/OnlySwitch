//
//  File.swift
//  SpringRadio
//
//  Created by jack on 2020/4/19.
//  Copyright © 2020 jack. All rights reserved.
//

import Foundation

class PlayerManager {
    static let shared = PlayerManager()
    var player:AudioPlayer = JLASAudioPlayer()
    
    var soundWaveEffectDisplay:Bool{
        Preferences.shared.soundWaveEffectDisplay
    }
    
    init() {
        if Preferences.shared.radioEnable {
            self.player.setupRemoteCommandCenter()
        }
        
        NotificationCenter.default.addObserver(forName: .soundWaveToggle, object: nil, queue: .main, using: { [self] _ in
            
            let currentPlayerItem = self.player.currentPlayerItem
            
            self.player.currentPlayerItem?.isPlaying = false
            self.player.clearCommandCenter()
            
            if soundWaveEffectDisplay {
                self.player = JLASAudioPlayer()
            } else {
                self.player = JLAVAudioPlayer()
            }
            self.player.currentPlayerItem = currentPlayerItem
            
            if Preferences.shared.radioEnable {
                self.player.setupRemoteCommandCenter()
            }
        })
    }
}
