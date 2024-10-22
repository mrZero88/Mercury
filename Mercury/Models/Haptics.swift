//
//  Haptics.swift
//  Saturn
//
//  Created by Daniel Correia on 02.12.23.
//

import SwiftUI

#if os(iOS)

func PlayHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
    if(HapticsOn) {
        _Concurrency.Task {
            await UIImpactFeedbackGenerator(style: style).impactOccurred()
        }
    }
}
#else

func PlayHaptic() {
    
}

#endif
