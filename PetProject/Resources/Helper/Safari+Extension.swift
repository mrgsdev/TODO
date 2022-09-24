//
//  Safari+Extension.swift
//  PetProject
//
//  Created by MRGS on 24.09.2022.
//

import UIKit
import SafariServices
extension SFSafariViewController{
    open override var modalPresentationStyle: UIModalPresentationStyle{
        get {
            return .fullScreen
        }
        set {
            super.modalPresentationStyle = newValue
        }
    }
}
