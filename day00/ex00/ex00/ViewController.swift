//
//  ViewController.swift
//  ex00
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
    
    @objc private func buttonTap() {
        print("Hello World!")
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
       configureButton()
       
    }


}

