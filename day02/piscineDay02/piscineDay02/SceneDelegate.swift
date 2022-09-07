//
//  SceneDelegate.swift
//  piscineDay02
//
//  Created by Artem Potekhin on 11.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let firstController = ViewController()
        let navigationController = UINavigationController(rootViewController: firstController)
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .dark
    }

 
}

