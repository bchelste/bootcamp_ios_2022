//
//  Shape.swift
//  piscineDay06
//
//  Created by Artem Potekhin on 17.08.2022.
//

import Foundation
import UIKit

//class Shape: UIView {
//
//    enum Shape: Int {
//        case rectangle = 0
//        case ellipse = 1
//    }
//
//    let figure: Shape
//
////    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
////        switch figure {
////        case .rectangle: return .rectangle
////        case .ellipse: return .ellipse
////        }
////    }
//
//    override init(frame: CGRect) {
//        print("creation of shape")
//        if Int(arc4random_uniform(2)) == 0 {
//            self.figure = Shape.rectangle
//        } else {
//            self.figure = Shape.ellipse
//        }
//
//        super.init(frame: frame)
//
//        switch figure {
//        case .ellipse: self.layer.cornerRadius = layer.bounds.width * 0.5
//        default: break
//        }
//
//        let redColor  = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//        let greenColor  = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//        let blueColor  = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//
//        let tmpColor = UIColor(red: redColor,
//                               green: greenColor,
//                               blue: blueColor,
//                               alpha: 1)
//        self.backgroundColor = tmpColor
//
////        self.clipsToBounds = true
////        self.layer.masksToBounds = true
////        self.isUserInteractionEnabled = true
//
//        print("shape was crated")
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class Shape: UIView {
    
    enum figure {
        case square
        case circle
    }
    
    let shapeType: figure
    
    override init(frame: CGRect) {
        print("creation of shape")
        let number = Int(arc4random_uniform(2))
        switch number {
        case 0: shapeType = .square
        default: shapeType = .circle
        }
        super.init(frame: frame)
        if number != 0 {
            self.layer.cornerRadius = layer.bounds.width * 0.5
        }
        
        let redColor  = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let greenColor  = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blueColor  = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        
        let tmpColor = UIColor(red: redColor,
                               green: greenColor,
                               blue: blueColor,
                               alpha: 1)
        self.backgroundColor = tmpColor
        
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        
        print("shape was crated")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch shapeType {
        case .circle: layer.cornerRadius = layer.bounds.width * 0.5
        default: break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
