//
//  ViewController.swift
//  piscineDay07
//
//  Created by Artem Potekhin on 18.08.2022.
// 

import UIKit
import RecastAI

class ViewController: UIViewController {
    
    let token = "VBVpUGH0MjZ6ctbsH6vgz0D1N8zGUXwx"
    lazy var bot = RecastAIClient(token: token, language: "en")
 
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 10
        button.tintColor = .white
        button.setTitle("Search ", for: .normal)
        let buttonImage = UIImage(systemName: "magnifyingglass.circle.fill")
        button.setImage(buttonImage, for: .normal)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 25)
        label.text = "search Result"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 25)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .yellow
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    func configureViewController() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        label.textColor = .clear
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 250),
            
            textField.widthAnchor.constraint(equalToConstant: 250),
            
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewController()
        
    }
    
    @objc func buttonTap() {
        print("button was tapped")
        if label.isHidden {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }


}
