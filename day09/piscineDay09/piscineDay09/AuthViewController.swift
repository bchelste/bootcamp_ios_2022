//
//  AuthViewController.swift
//  piscineDay09
//
//  Created by Artem Potekhin on 22.08.2022.
//

import Foundation
import LocalAuthentication
import UIKit

class AuthViewController: UIViewController {
    
    let authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemMint
        button.setTitle("Authentication".localized(), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        return button
    }()
    
    func configureButton() {
        authButton.addTarget(self,
                             action: #selector(buttonTap),
                             for: .touchUpInside)
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate([
            authButton.widthAnchor.constraint(equalToConstant: 200),
            authButton.heightAnchor.constraint(equalToConstant: 50),
            authButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            authButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc func buttonTap() {
        print("authButton was tapped")
        
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthentication,
                                     error: &error) {
            let reason = "Please authorize with your biometrics"
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate",
                                                      message: "Please try again",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss",
                                                      style: .cancel,
                                                      handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                    let viewController = ViewController()
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.modalPresentationStyle = .fullScreen
//                    navigationController.navigationBar.barTintColor = .blue
                    
                    self?.present(navigationController,
                                  animated: true,
                                  completion: nil)
                }
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Unavailable",
                                              message: "you cat not use this feature",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                                              style: .cancel,
                                              handler: nil))
                self.present(alert, animated: true)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureButton()
        
    }
}
