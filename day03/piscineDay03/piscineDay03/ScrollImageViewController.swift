//
//  ScrollImageViewController.swift
//  piscineDay03
//
//  Created by Artem Potekhin on 13.08.2022.
//

import UIKit

class ScrollImageViewController: UIViewController {
    
    var currentItem = 0
    
    var imageScrollView: CustomScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        imageScrollView = CustomScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupConstraints()
        
        imageScrollView.set(image: getImage())

    }
    
    func getImage() -> UIImage {
        var index = 0
        for (i, item) in URLSessionManager.shared.imageStorage.enumerated() {
            if item.0 == currentItem {
                index = i
                break ;
            }
        }
        return URLSessionManager.shared.imageStorage[index].1
    }
    
    func setupConstraints() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
}

extension ScrollImageViewController: InfoDelegate{
    func sendInfo(item: Int) {
        currentItem = item
        print("secondCV get item: \(currentItem)")
    }
}
