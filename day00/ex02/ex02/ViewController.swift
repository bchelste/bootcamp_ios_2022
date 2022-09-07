//
//  ViewController.swift
//  ex02
//
//  Created by Artem Potekhin on 09.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
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
//        stackView.backgroundColor = .yellow
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
    
    @objc func buttonTap(button: UIButton) {
        let name = button.currentTitle ?? ""
        switch name {
        case "0"..."9": label.text = name
        default: break
        }
        print("button " + name + " was tapped")
    }
    
    func generateButton(title: String, titleColor: UIColor, buttonColor: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        if title != " " {
            button.backgroundColor = buttonColor
        }
        button.setTitleColor(titleColor, for: .normal)
        button.addTarget(self, action: #selector(buttonTap(button: )), for: .touchUpInside)
        return button
    }
    
    func addCalculatorButtons() {
        for (index, column) in buttonTittles.enumerated() {
            let columnStack = UIStackView()
//            columnStack.backgroundColor = .purple
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


}



