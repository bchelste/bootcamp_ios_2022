//
//  CustomScrollView.swift
//  piscineDay03
//
//  Created by Artem Potekhin on 13.08.2022.
//

import UIKit

class CustomScrollView: UIScrollView, UIScrollViewDelegate {
    
    var imageZoomVeiw: UIImageView!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage){

        imageZoomVeiw = nil
        
        imageZoomVeiw = UIImageView(image: image)
        self.addSubview(imageZoomVeiw)
        
        configurate(imageSize: image.size)
    }
    
    func configurate(imageSize: CGSize) {
        self.contentSize = imageSize
        
        setMaxMinZoomScale()
        self.zoomScale = self.minimumZoomScale
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }
    
    func setMaxMinZoomScale() {
        let boundsSize = self.bounds.size
        let imageSize = imageZoomVeiw.bounds.size

        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)

        var maxScale: CGFloat = 2.0
        if minScale < 0.25 {
            maxScale = 0.5
        } else if (minScale >= 0.25 && minScale < 1) {
            maxScale = 1.25
        } else if minScale >= 1 {
            maxScale = max(2.0, minScale)
        }
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale

    }

    func centerImage() {
        let boundsSize = self.bounds.size
        var frameToCenter = imageZoomVeiw.frame

        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }

        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }

        imageZoomVeiw.frame = frameToCenter

    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomVeiw
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }


}
