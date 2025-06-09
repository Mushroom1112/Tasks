//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Giorgi Amiranashvili on 05.06.25.
//

import UIKit

class CalculatorViewController: UIViewController {
    var firstNumber: String?
    var secondNumber: String?
    var runningNumber: String?
    var operatorValue: String?
    var justCalculated = false
    
    let resultView: UIView = {
        let view = UIView()
        view.backgroundColor = .resultView
        return view
    }()
    
    let keyboardView: UIView = {
        let view = UIView()
        view.backgroundColor = .keyboard
        view.layer.cornerRadius = 14
        return view
    }()
    
    let calculationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .calculationHistory
        label.backgroundColor = .clear
        label.textAlignment = .right
        label.text = "Built with love and too many breakpoints."
        label.textColor = .historyNumber
        return label
    }()
    
    let operationLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        label.textColor = .calculation
        label.backgroundColor = .clear
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    let emojiLabel: UILabel = {
        let emoji = UILabel()
        emoji.text = "⨋ ..."
        emoji.font = .systemFont(ofSize: 100)
        return emoji
    }()
    
    let allButtons: [ButtonKind] = [
        .operator("AC"), .operator("÷"), .operator("×"), .operator("＋"),
        .number("1"), .number("2"), .number("3"), .operator("﹣"),
        .number("4"), .number("5"), .number("6"), .number("."),
        .number("7"), .number("8"), .number("9"), .number("0"),
        .operator("=")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .resultView
        resultView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        keyboardView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: view.frame.height - 300)
        
        configureOperationLabel()
        configureLabel()
        configurebuttonStack()
        
        view.addSubview(resultView)
        view.addSubview(keyboardView)
        resultView.addSubview(operationLabel)
        resultView.addSubview(calculationLabel)
        keyboardView.addSubview(emojiLabel)
        
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiLabel.heightAnchor.constraint(equalToConstant: 150),
            emojiLabel.widthAnchor.constraint(equalToConstant: 150),
            emojiLabel.bottomAnchor.constraint(equalTo: keyboardView.bottomAnchor, constant: -25),
            emojiLabel.centerXAnchor.constraint(equalTo: keyboardView.centerXAnchor),
        ])
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.emojiLabel.transform = CGAffineTransform(translationX: 0, y: -20)
        })
    }
    
    func configureOperationLabel() {
        let height: CGFloat = 60
        let fittingSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let textSize = operationLabel.sizeThatFits(fittingSize)

        let fieldX = resultView.frame.maxX - textSize.width - 20
        let fieldY = resultView.frame.maxY - textSize.height - 10
        operationLabel.frame = CGRect(x: fieldX, y: fieldY, width: textSize.width, height: textSize.height)
    }
    
    func configureLabel() {
        let width = view.frame.width - 40
        let fittingSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textSize = calculationLabel.sizeThatFits(fittingSize)
        
        let labelY = operationLabel.frame.minY - textSize.height - 10
        let labelX = operationLabel.frame.maxX - 350
        
        calculationLabel.frame = CGRect(x: labelX, y: labelY, width: 350, height: textSize.height)
    }
    
    func configurebuttonStack() {
        let buttonSize: CGFloat = 64
        let spacing: CGFloat = 16
        let buttonsPerRow = 4
        
        let mainStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = spacing
            stackView.distribution = .fillEqually
            return stackView
        }()
        
        var rowStackView: UIStackView?
        
        for (index, kind) in allButtons.enumerated() {
            if index % buttonsPerRow == 0 {
                rowStackView = UIStackView()
                guard let stack = rowStackView else { return }
                stack.axis = .horizontal
                stack.spacing = spacing
                stack.distribution = .equalSpacing
                mainStack.addArrangedSubview(stack)
            }
            let name: String
            
            switch kind {
            case .number(let value):
                name = value
            case .operator(let value):
                name = value
            }
            
            let button = ReusableButton(kind: kind, title: name)
            button.tag = index
            rowStackView?.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: 25),
            mainStack.leftAnchor.constraint(equalTo: keyboardView.leftAnchor, constant: 25),
            mainStack.rightAnchor.constraint(equalTo: keyboardView.rightAnchor, constant: -25),
            mainStack.heightAnchor.constraint(equalToConstant: 380)
        ])
    }
    
    func operationLabelDidChanged(_ label: UILabel) {
        let height: CGFloat = 60
        
        let fittingSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let textSize = label.sizeThatFits(fittingSize)
        
        let fieldX = view.frame.maxX - textSize.width - 20
        let fieldY = resultView.frame.maxY - textSize.height - 10
        
        UIView.animate(withDuration: 0.1) {
            label.frame = CGRect(x: fieldX, y: fieldY, width: textSize.width, height: textSize.height)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let currentButton = allButtons[sender.tag]
        var currentText = operationLabel.text ?? "0"
        
        switch currentButton {
        case .operator("AC"):
            firstNumber = nil
            secondNumber = nil
            runningNumber = nil
            operatorValue = nil
            justCalculated = false
            
            operationLabel.text = "0"
            calculationLabel.text = "History Goes Here..."
            operationLabelDidChanged(operationLabel)
            
        case .number(let number):
            if justCalculated {
                currentText = number
                justCalculated = false
            } else if currentText == "0" && number != "." {
                currentText = number
            }else if number == "." && currentText.contains(".") {
                
            } else {
                currentText += number
            }
            runningNumber = currentText
            operationLabel.text = runningNumber
            operationLabelDidChanged(operationLabel)
            
        case .operator(let operation):
            tappedOperation(operation)
        }
    }
    
    func tappedOperation(_ operandSymbol: String) {
        if let currentNumberStr = runningNumber {
            if firstNumber == nil {
                firstNumber = currentNumberStr
            } else if secondNumber != nil || operatorValue != nil {
                secondNumber = currentNumberStr
                let result = calculate()
                firstNumber = String(result)
                operationLabel.text = firstNumber
                operationLabelDidChanged(operationLabel)
            }
        }
        
        if operandSymbol != "=" {
            operatorValue = operandSymbol
        } else {
            operatorValue = nil
        }
        runningNumber = nil
        justCalculated = true
    }
    
    func calculate() -> Double {
        guard let firstStr = firstNumber, let firstOperand = Double(firstStr) else { return 0 }
        var result: Double = firstOperand
        
        if let op = operatorValue, let secondStr = secondNumber ?? runningNumber, let secondOperand = Double(secondStr) {
            switch op {
            case "＋":
                result = firstOperand + secondOperand
                result = roundIfNeeded(result)
            case "﹣":
                result = firstOperand - secondOperand
                result = roundIfNeeded(result)
            case "×":
                result = firstOperand * secondOperand
                result = roundIfNeeded(result)
            case "÷":
                if secondOperand != 0 {
                    result = firstOperand / secondOperand
                    result = roundIfNeeded(result)
                } else {
                    
                    DispatchQueue.main.async {
                        self.calculationLabel.text = "Can't divide by 0. Try again later..."
                        self.calculationLabel.textColor = .red
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.calculationLabel.text = "You + Me = 💙 (Only in debug mode)"
                        self.calculationLabel.textColor = .historyNumber
                    }
                    result = 0
                }
            default:
                break
            }
            firstNumber = String(result)
        }
        return result
    }
    func roundIfNeeded(_ number: Double, toDecimalPlaces places: Int = 8) -> Double {
        let scaledNumber = number * pow(10.0, Double(places))
        let decimalPart = scaledNumber - floor(scaledNumber)
        
        if decimalPart > Double.ulpOfOne {
            let factor = pow(10.0, Double(places))
            return (number * factor).rounded() / factor
        } else {
            return number
        }
    }
}
