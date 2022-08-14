//
//  MainTaskCell.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class MainTaskCell: UITableViewCell {
    let labelMain: UILabel = {
        let label = UILabel()
        label.text = "Create new "
        label.textColor = UIColor(rgb: 0x8391A1)
        if let customFont = UIFont(name: "Urbanist-ExtraLight", size: 16) {
            let fontMetrics = UIFontMetrics(forTextStyle: .headline)
            label.font = fontMetrics.scaledFont(for: customFont)
        }
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    static let mainTextField: CustomTextField = {
        let email = CustomTextField()
        email.placeholder = "Enter new note"
        email.font = UIFont(name: "Urbanist-Medium", size: 18)
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.addArrangedSubview(labelMain)
        stackView.addArrangedSubview(MainTaskCell.mainTextField)
        contentView.addSubview(stackView)
        //        contentView.addSubview(labelMain)
        
        NSLayoutConstraint.activate([
            labelMain.heightAnchor.constraint(equalToConstant: 33),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 15),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -15),
            
            //            mainTextField.topAnchor.constraint(equalTo: labelMain.topAnchor),
            //            mainTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            //            mainTextField.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            //            mainTextField.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
