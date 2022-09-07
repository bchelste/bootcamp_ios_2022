//
//  CustomCollectionViewCell.swift
//  piscineDay03
//
//  Created by Artem Potekhin on 12.08.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "CustomCollectionViewCell"
    
    let imageView = UIImageView()
    let contentContainer = UIView()
    let activityIndicator = UIActivityIndicatorView()

    func configure() {
        
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        contentContainer.backgroundColor = .black
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(imageView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(activityIndicator)
        activityIndicator.color = .white
        
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor)
          
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configureCell(item: Int, controller: UIViewController) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        URLSessionManager.shared.downloadImage(item: item, controller: controller) { image in
            DispatchQueue.main.async {
                if image == nil {
                    self.showAlertController(url: URLSessionManager.shared.images[item],
                                        controller: controller)
                    return
                }
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.imageView.image = image
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAlertController(url: String, controller: UIViewController) {
        let alert = UIAlertController(title: "Error",
                                      message: "Cannot access to " + url,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        controller.present(alert, animated: true)
    }
    
}
