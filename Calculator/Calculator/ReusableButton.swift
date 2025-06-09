//
//  ReusableButton.swift
//  Calculator
//
//  Created by Giorgi Amiranashvili on 05.06.25.
//

import UIKit

enum ButtonKind: Equatable {
    case number(String)
    case `operator`(String)
}

class ReusableButton: UIButton {
    var kind: ButtonKind
    private var originalBackgroundColor: UIColor?
    
    init(kind: ButtonKind, title: String) {
        self.kind = kind
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.layer.cornerRadius = 32
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0.267, green: 0.275, blue: 0.294, alpha: 1)
        
        switch kind {
        case .operator(_):
            self.backgroundColor = .button
        case .number(_):
            self.backgroundColor = .clear
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                if self.isHighlighted {
                    self.titleLabel?.font = UIFont.systemFont(ofSize: 40)
                    self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
                } else {
                    self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
                    self.backgroundColor = self.originalBackgroundColor
                }
            }
        }
    }
}
