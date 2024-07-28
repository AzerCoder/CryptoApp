//
//  HapticManager.swift
//  CryptoApp
//
//  Created by A'zamjon Abdumuxtorov on 27/07/24.
//

import SwiftUI

class HapticManager{
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
