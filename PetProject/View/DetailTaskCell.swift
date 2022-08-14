//
//  DetailTaskCell.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class DetailTaskCell: UITableViewCell {
    let labelMain: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.textColor = UIColor(rgb: 0x8391A1)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailTextView: UITextView = {
        let view = UITextView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 15
            view.layer.masksToBounds = true
            view.backgroundColor = .white
        view.textContainerInset = .zero
        view.showsVerticalScrollIndicator = false
        view.textContainer.lineFragmentPadding = 20
        view.layer.cornerRadius = 15.0
        view.backgroundColor = UIColor(rgb: 0xF7F8F9)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(rgb: 0xE8ECF4).cgColor
        view.clipsToBounds = true
        view.tintColor = UIColor(rgb: 0x8391A1)
        view.font = UIFont(name: "Urbanist-Medium", size: 18)
            return view
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.distribution  = .fill
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
        stackView.addArrangedSubview(detailTextView)
        contentView.addSubview(stackView)
//        contentView.addSubview(labelMain)
  
        NSLayoutConstraint.activate([
            labelMain.heightAnchor.constraint(equalToConstant: 33),
//            detailTextView.heightAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 15),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -15),
//
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
