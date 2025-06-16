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
    let upperLabel: UILabel = {
        let label = UILabel()
        label.text = "Something Sweet"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()
    
    let belowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click Here", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(upperLabel)
        view.addSubview(belowButton)
        
        upperLabel.translatesAutoresizingMaskIntoConstraints = false
        belowButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            upperLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5)
,
            
            belowButton.centerXAnchor.constraint(equalTo: upperLabel.centerXAnchor),
            belowButton.topAnchor.constraint(equalTo: upperLabel.bottomAnchor, constant: 30)
        ])
        
    }
}

#Preview {
    Task2ViewController()
}
