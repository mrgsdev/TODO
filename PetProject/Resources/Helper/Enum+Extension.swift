//
//  Enum+Extension.swift
//  PetProject
//
//  Created by MRGS on 24.09.2022.
//

import UIKit
import AudioToolbox
//MARK: - ImageSet enum
enum imageSet:String{
    case googleIcon = "googleIcon"
    case background = "background"
    case userLogo = "userLogo"
    case plus = "plus"
    case personFill = "person.fill"
    case backButton = "chevron.backward"
    case checkmark = "checkmark"
    case sadface = "sadFace"
    case moneyface = "moneyFace"
    case smileface = "smileFace"
    case thinkingFace = "thinkingFace"
}

//MARK: - Vibration
enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    @available(iOS 13.0, *)
    case soft
    @available(iOS 13.0, *)
    case rigid
    case selection
    case oldSchool
    
    public func vibrate() {
        switch self {
        case .error: // легкая double вибрация
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success: // легкая вибрация
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning: // легкая с задержкой
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light: //легкая один раз
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        case .rigid:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
