//
//  ViewController.swift
//  piscineDay05
//
//  Created by Artem Potekhin on 14.08.2022.
//

import UIKit

class ViewController: UITabBarController {
    
    let firstViewController: FirstViewController = {
        let viewController  = FirstViewController()
        viewController.view.backgroundColor = .yellow
        viewController.title = "Map"
        return viewController
    }()
    
    let secondViewController: SecondViewController = {
        let viewController  = SecondViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = "List"
        return viewController
    }()
    
    let thirdViewController: ThirdViewController = {
        let viewController  = ThirdViewController()
        viewController.view.backgroundColor = .systemPink
        viewController.title = "More"
        return viewController
    }()
    
    func configureTabBarController() {
        self.setViewControllers([firstViewController,
                                secondViewController,
                                thirdViewController],
                                animated: true)
        
        secondViewController.tabBarDelegate = self
        secondViewController.openMapDelegate = firstViewController
        
        guard let items = tabBar.items else { return }
        let tabBarImages = ["map", "list.star", "ellipsis"]
        for (i, image) in tabBarImages.enumerated() {
            items[i].image = UIImage(systemName: image)
        }
        
        self.tabBar.tintColor = .link
        self.tabBar.backgroundColor = UIColor(named: "tabBarBackground")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        let number = self.viewControllers?.count ?? 0
        if number > 1 {
            self.selectedIndex = 1
        }
    }


}

extension ViewController: TabBarDelegate {
    func openFirstViewController() {
        guard let number = self.viewControllers?.count else { return }
        if number != 0 {
            self.selectedIndex = 0
        }
    }
    
    
}
