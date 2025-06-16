//
//  Task2.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {
    private let someLabel: UILabel = {
        let label = UILabel()
        label.text = " I am the one who knocks 🕶️🧪"
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .cyan
        return label
    }()
    
    private let someButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Say my name", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setup()
    }
    
    private func setup() {
        view.addSubview(someLabel)
        view.addSubview(someButton)
        
        someLabel.translatesAutoresizingMaskIntoConstraints = false
        someButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            someLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10),
            someLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            someButton.centerXAnchor.constraint(equalTo: someLabel.centerXAnchor),
            someButton.topAnchor.constraint(equalTo: someLabel.bottomAnchor, constant: 20)
        ])
    }
}

#Preview {
    Task2ViewController()
}
