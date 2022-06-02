//
//  HapticManager.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 28/05/22.
//

import SwiftUI

class HapticManager { // haptic singleton class
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
