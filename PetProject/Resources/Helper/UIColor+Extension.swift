//
//  UIColor+Extension.swift
//  PetProject
//
//  Created by MRGS on 24.09.2022.
//

import UIKit
extension UIColor{
    /*
     Label.Secondary = TextField.Label.Placeholder
     
     
     */
    
    /*
     Label.Primary(labelPrimary) - к заголовкам
     Label.Secondary(labelSecondary) - к обычному тексту
     Label.Tertiary(labelTertiary) - к любому другому(например,в LoginVC forgotPassword)
     
     TextField.Label.Placeholder - к ячейкам,к placeholder'ам,к тексту в TextField
     TextField.Background - background UITextField'а
     
     Button.Background(background) - background UIButton
     Button.Font(label) - font UIButton
     */
    
    final class Label{
        static let labelPrimary = UIColor(named: "Label.Primary")
        static let labelSecondary = UIColor(named: "Label.Secondary")
        static let labelTertiary = UIColor(named: "Label.Tertiary")
    }
    final class PageControl{
        static let pageActive = UIColor(named: "Page.Active")
        static let pageBackground = UIColor(named: "Page.Background")
    }
    
    final class TextField{
        // Label.Secondary = TextField.Label.Placeholder
        static let label = UIColor(named: "TextField.Label.Placeholder")
        static let placeholder = UIColor(named: "TextField.Label.Placeholder")
        static let background = UIColor(named: "TextField.Background")
    }
    final class Button{
        static let label = UIColor(named: "Button.Font")
        static let background = UIColor(named: "Button.Background")
    }
    final class Support{
        static let background = UIColor(named: "Main.Background")
        static let border = UIColor(named: "Main.Border")
    }
    final class Alert{
        static let background = UIColor(named: "Alert.Background")
        static let labelPrimary = UIColor(named: "Label.Primary")
        static let labelSecondary = UIColor(named: "Label.Secondary")
        static let labelTertiary = UIColor(named: "Label.Tertiary")
    }
}
