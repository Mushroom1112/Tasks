//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        registerForTraitChanges()
    }
    
    private func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
    }
    
    private func setupConstraints() {
        verticalConstraints = [
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            redView.heightAnchor.constraint(equalToConstant: 100),
            
            blueView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 20),
            blueView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            blueView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        horizontalConstraints = [
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            redView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            redView.heightAnchor.constraint(equalToConstant: 100),
            
            blueView.topAnchor.constraint(equalTo: redView.topAnchor),
            blueView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 10),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blueView.heightAnchor.constraint(equalTo: redView.heightAnchor)
        ]
        
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .compact {
            NSLayoutConstraint.activate(verticalConstraints)
        } else {
            NSLayoutConstraint.activate(horizontalConstraints)
        }
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            print("Trait collection changed:", self.traitCollection)
            
            NSLayoutConstraint.deactivate(self.verticalConstraints)
            NSLayoutConstraint.deactivate(self.horizontalConstraints)
            
            if self.traitCollection.verticalSizeClass == .regular && self.traitCollection.horizontalSizeClass == .compact {
                NSLayoutConstraint.activate(self.verticalConstraints)
            } else {
                NSLayoutConstraint.activate(self.horizontalConstraints)
            }
        }
    }
}

#Preview {
    Task4ViewController()
}
