//
//  ToDoCell.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    let labelText: UILabel = {
        let label = UILabel()
        label.text = "TodoCell"
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .colorSetTextFieldFont
        label.font = UIFont(name: UIFont.urbanistMedium , size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let containerView:CustomView = {
      let view = CustomView()
        view.layer.cornerRadius = 15.0
        view.layer.borderWidth = 1.0
        view.backgroundColor = UIColor.TextField.background
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20);
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.Support.background
        contentView.addSubview(containerView)
        contentView.addSubview(labelText)
        
        NSLayoutConstraint.activate([
          labelText.topAnchor.constraint(equalTo: containerView.topAnchor),
           labelText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
             labelText.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 15),
         labelText.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
