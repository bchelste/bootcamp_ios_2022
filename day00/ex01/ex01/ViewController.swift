//
//  ViewController.swift
//  ex01
//
//  Created by Artem Potekhin on 09.08.2022.
//

import UIKit

class ViewController: UIViewController {

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello World!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        return stack
    }()
    
    @objc private func buttonTap() {
        print("Hello World!")
        if label.text == "Hello World!" {
            label.text = "Piscine Swift IOS"
        } else {
            label.text = "Hello World!"
        }
        
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        configureButton()
        stackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureStackView()
       
    }
    
}

