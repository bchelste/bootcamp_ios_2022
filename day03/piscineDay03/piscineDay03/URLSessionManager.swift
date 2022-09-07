//
//  URLSessionManager.swift
//  piscineDay03
//
//  Created by Artem Potekhin on 13.08.2022.
//

import Foundation
import UIKit

class URLSessionManager {
    
    static let shared = URLSessionManager()
    
    var images = [
        "https://www.nasa.gov/sites/default/files/thumbnails/image/curiosity_selfie.jpg",
        "test error url",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/ksc-20211109-ph-jbs01_0151_orig.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/us_lights2.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/ksc-20210303-ph-ilw01_0008.jpg",

    ]
    
    var imageStorage = [(Int, UIImage)]()
    
    let emptyImage: UIImage = {
        var image = UIImage(named: "empty") ?? UIImage()
        return image
    }()
    
    func downloadImage(item: Int, controller: UIViewController, complition: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: images[item]) else {
            self.imageStorage.append((item, emptyImage))
            complition(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                self.imageStorage.append((item, UIImage(data: data)!))
                complition(UIImage(data: data))
            } else {
                self.imageStorage.append((item, self.emptyImage))
                complition(nil)
                return
            }
        }.resume()
    }
    
}
