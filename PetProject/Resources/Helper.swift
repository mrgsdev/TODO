//
//  Helper.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//


import UIKit
import AudioToolbox

/*
 if let customFont = UIFont(name: "Urbanist-SemiBold", size: 30) {
     let fontMetrics = UIFontMetrics(forTextStyle: .title1)
     label.font = fontMetrics.scaledFont(for: customFont)
 }
 */

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
    static let colorSetTextFieldFill = UIColor(named: "textFieldFill")
    static let colorSetTextFieldFont = UIColor(named: "textFieldFont")
}
//MARK: - Image enum
enum imageSet:String{
    case googleIcon = "googleIcon"
    case background = "background"
    case userLogo = "userLogo"
    case plus = "plus"
    case personFill = "person.fill"
    case backButton = "chevron.backward"
    case checkmark = "checkmark"
    case sadface = "sadface"
}

//MARK: - UIFont extension
extension UIFont{
    static let urbanistBold = "Urbanist-Bold"
    static let urbanistRegular = "Urbanist-Regular"
    static let urbanistSemiBold = "Urbanist-SemiBold"
    static let urbanistExtraLight = "Urbanist-ExtraLight"
    static let urbanistMedium = "Urbanist-Medium"
}

//MARK: - UIViewController extension
extension UIViewController{
    func clearBackgroundNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}

//MARK: - UIBarButtonItem extension
extension UIBarButtonItem {
    
    static func addButton(systemNameIcon:String,_ target: Any?, action: Selector) -> UIBarButtonItem {
        let button = CustomButton()
        let largeFont = UIFont.systemFont(ofSize: 20)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        button.setImage(UIImage(systemName: systemNameIcon,withConfiguration: configuration), for: .normal)
        button.tintColor = .colorSetTextFieldFont
        button.layer.borderWidth = 2
        button.backgroundColor = .colorSetTextFieldFill
        button.layer.cornerRadius = 12
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 41).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 41).isActive = true
        
        return menuBarItem
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    
}



extension NSMutableAttributedString {
    var fontSize:CGFloat { return 16 }
    var boldFont:UIFont { return UIFont(name: UIFont.urbanistBold, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: UIFont.urbanistExtraLight, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [.font : boldFont]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    func boldUnderlined(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
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










