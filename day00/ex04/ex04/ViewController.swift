//
//  ViewController.swift
//  ex04
//
//  Created by Artem Potekhin on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var result: Double = 0
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var memory: String = " "
    var flag: Bool = false
    
    var state : State = .waitFirstOperand
    
   
    
    enum State {
        case waitFirstOperand
        case inputFirstOperand
        case waitSecondOperand
        case inputSecondOperand
        case resultWasTapped
        case errorState
    }
    
    let buttonTittles = [
    ["1", "4", "7", " "],
    ["2", "5", "8", "0"],
    ["3", "6", "9", " "],
    ["AC", "+", "-", "="],
    ["NEG", "*", "/", " "]
    ]
    
    let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 5
        return view
    }()
    
    func configureBackground() {
        view.addSubview(background)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            background.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            background.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        label.text = "0"
        return label
    }()
    
    func configureLabel() {
        background.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: background.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -10),
            label.heightAnchor.constraint(equalTo: background.heightAnchor, multiplier: 0.15)
        ])
    }
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    func configureButtonStackView() {
        background.addSubview(buttonStackView)
        
        addCalculatorButtons()
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            buttonStackView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            buttonStackView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -5)
        ])
    }
    
    func generateButton(title: String, titleColor: UIColor, buttonColor: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        if title != " " {
            button.backgroundColor = buttonColor
        }
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTap(button: )), for: .touchUpInside)
        return button
    }
    
    func addCalculatorButtons() {
        for (index, column) in buttonTittles.enumerated() {
            let columnStack = UIStackView()
            columnStack.translatesAutoresizingMaskIntoConstraints = false
            columnStack.axis = .vertical
            columnStack.alignment = .fill
            columnStack.distribution = .fillEqually
            columnStack.spacing = 5
            for item in column {
                if (index <= 2) && (index >= 0) {
                    columnStack.addArrangedSubview(generateButton(title: item, titleColor: .white, buttonColor: .systemOrange))
                } else {
                    columnStack.addArrangedSubview(generateButton(title: item, titleColor: .black, buttonColor: .systemGray))
                }
                
            }
            buttonStackView.addArrangedSubview(columnStack)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureBackground()
        configureLabel()
        configureButtonStackView()
    }
    
    // MARK: - Handle Calculations

    @objc func buttonTap(button: UIButton) {
        let name = button.currentTitle ?? ""
        switch name {
        case "0"..."9":
            handleDigit(value:name)
        case "=":
            handleResult()
        case "AC":
            handleReset()
        case "NEG":
            handleNEG()
        case "+", "-", "*", "/":
            handleOperation(operation: name)
        default: break
        }
        print("button " + name + " was tapped")
        outputData()
    }
    
    func handleDigit(value: String) {
        if ((firstOperand == 999999999) && (state == .inputFirstOperand) || (secondOperand == 999999999) && (state == .inputSecondOperand)) {
            return
        }
        if flag {
            firstOperand = Double(NSString(string: value).intValue)
            label.text = value
            result = 0
            return
        }
        switch state {
        case .waitFirstOperand:
            firstOperand = Double(NSString(string: value).intValue)
            label.text = value
            state = .inputFirstOperand
            
        case .inputFirstOperand:
            let tmp = firstOperand * 10 + Double(NSString(string: value).intValue)
            firstOperand = tmp
            var tmpLabel = label.text ?? ""
            tmpLabel += value
            label.text = tmpLabel
            state = .inputFirstOperand
            
        case .waitSecondOperand:
            secondOperand = Double(NSString(string: value).intValue)
            label.text = value
            state = .inputSecondOperand
            
        case .inputSecondOperand:
            let tmp = secondOperand * 10 + Double(NSString(string: value).intValue)
            secondOperand = tmp
            var tmpLabel = label.text ?? ""
            tmpLabel += value
            label.text = tmpLabel
            state = .inputSecondOperand
            
        case .resultWasTapped:
            firstOperand = result
            secondOperand = Double(NSString(string: value).intValue)
            label.text = value
            
        default: break
        }
        flag = false
    }
    
    func handleResult() {
        switch state {
        case .inputFirstOperand:
            firstOperand = 0
            state = .waitSecondOperand
        case .waitSecondOperand:
            handleCalculations(first: firstOperand, second: firstOperand)
            secondOperand = firstOperand
            firstOperand = result
//            label.text = "\(result)"
            state = .resultWasTapped
        case .inputSecondOperand, .resultWasTapped:
            handleCalculations(first: firstOperand, second: secondOperand)
            firstOperand = result
//            label.text = "\(result)"
            state = .resultWasTapped
        default: break
        }
        flag = true
    }
    
    func handleReset() {
        result = 0
        firstOperand = 0
        secondOperand = 0
        memory = " "
        state = .waitFirstOperand
        label.textColor = .white
        label.text = "0"
        print("calculator was reseted")
        flag = false
    }
    
    func handleNEG() {
        switch state {
        case .inputFirstOperand:
            firstOperand = changeSign(value: firstOperand)
        case .inputSecondOperand:
            secondOperand = changeSign(value: secondOperand)
            label.text = "\(secondOperand)"
        case.resultWasTapped:
            result = changeSign(value: result)
            firstOperand = result
            if result.isFinite == false {
                label.textColor = .systemRed
                label.text = "Calculation Error"
            } else {
                label.text = "\(result)"
            }
        default: break
        }
        flag = false
    }
    
    func changeSign(value: Double) -> Double {
        var changed = value
        changed *= (-1)
        return changed
    }
    
    func handleOperation(operation: String) {
        
        switch state {
        case .waitFirstOperand:
            firstOperand = 0;
            state = .waitSecondOperand
        case .inputFirstOperand:
            state = .waitSecondOperand
        case .waitSecondOperand:
            state = .waitSecondOperand
        case .inputSecondOperand:
            handleCalculations(first: firstOperand, second: secondOperand)
            firstOperand = result
            state = .resultWasTapped
        case .resultWasTapped:
            firstOperand = result
            secondOperand = result
            state = .waitSecondOperand
        default:
            break
        }
        memory = operation
        flag = false
    }
    
    func handleCalculations(first: Double, second: Double) {
        switch memory {
        case "+":
            result = first + second
        case "-":
            result = first - second
        case "*":
            result = first * second
        case "/":
            result = first / second
        default:
            break
        }
        if result.isFinite == false {
            label.textColor = .systemRed
            label.text = "Calculation Error"
            print(result.isFinite)
            
        } else {
            label.text = "\(result)"
        }
    }
    
    func outputData() {
        print("---------------------------------------------")
        print("result = \(result)")
        print("firstOperand = \(firstOperand)")
        print("secondOperand = \(secondOperand)")
        print("operation in memory: \(memory)")
        print("actual STATE: \(state)")
        print("flag: \(flag)")
        print("---------------------------------------------")
        print("\n")
    }
    
    
    
}



