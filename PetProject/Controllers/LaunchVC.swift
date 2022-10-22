//
//  LaunchVC.swift
//  PetProject
//
//  Created by MRGS on 09.09.2022.
//

import UIKit
class LaunchVC: UIViewController {
    //MARK: Create UI with Code
    private let imageNotes: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "LaunchScreenLogo"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    private let waiting: UILabel = {
        let label = UILabel()
        label.text = "Waiting..."
        label.font = UIFont(name: UIFont.urbanistBold, size: 25)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Component
    lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
        view.color = .black
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints() 
    }
    func makeConstraints()  {
        view.addSubview(imageNotes)
        view.addSubview(waiting)
        view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            imageNotes.heightAnchor.constraint(equalToConstant: 320),
            imageNotes.widthAnchor.constraint(equalToConstant: 250),
            imageNotes.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageNotes.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            waiting.topAnchor.constraint(equalTo: imageNotes.bottomAnchor),
            waiting.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.topAnchor.constraint(equalTo: waiting.bottomAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

     

}
