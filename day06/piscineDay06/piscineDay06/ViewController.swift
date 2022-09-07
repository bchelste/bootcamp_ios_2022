//
//  ViewController.swift
//  piscineDay06
//
//  Created by Artem Potekhin on 16.08.2022.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
    
    var shapeStorage = [UIDynamicItem]()
    
    let shapeWidth = 100
    let shapeHeight = 100
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    let gravity = UIGravityBehavior(items: [])
    let collision = UICollisionBehavior(items: [])
    let reboundSquare = UIDynamicItemBehavior(items: [])
    let reboundCircle = UIDynamicItemBehavior(items: [])
    let motionManager = CMMotionManager()
    
    
    
    func configureBehavior() {
        gravity.magnitude = 1
        collision.translatesReferenceBoundsIntoBoundary = true
        reboundSquare.elasticity = 0.5
        reboundSquare.density = 2
        reboundCircle.elasticity = 1
        reboundCircle.density = 1
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(reboundSquare)
        animator.addBehavior(reboundCircle)
    }
    
    func configureView() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self,
                                             action: #selector(tapGestureHandle))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureBehavior()

        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { motion, motionError in
            guard let data  = motion else { return }
            let g = data.gravity
            DispatchQueue.main.async {
                self.gravity.gravityDirection = CGVector(dx: g.x, dy: -g.y)
            }
            
        }
    }
    
    @objc func tapGestureHandle(recognizer: UITapGestureRecognizer) {
        print("TAP gesture was recognized")
        
        let positionX = recognizer.location(in: self.view).x
        let positionY = recognizer.location(in: self.view).y
        let shape = Shape(frame: CGRect(origin: CGPoint(x: (positionX - CGFloat(shapeWidth) * 0.5),
                                                        y: positionY - CGFloat(shapeHeight) * 0.5),
                                        size: CGSize(width: shapeWidth, height: shapeHeight)))
        
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(panGestureHandle))
        shape.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self,
                                                action: #selector(pinchGestureHandle))
        shape.addGestureRecognizer(pinchGesture)
        let rotationGesture = UIRotationGestureRecognizer(target: self,
                                                          action: #selector(rotationGestureHandle))
        shape.addGestureRecognizer(rotationGesture)
        self.view.addSubview(shape)
        shapeStorage.append(shape)
        gravity.addItem(shape)
        collision.addItem(shape)
        shape.shapeType == .square ? reboundSquare.addItem(shape) : reboundCircle.addItem(shape)
    }
    
    @objc func panGestureHandle(recognizer: UIPanGestureRecognizer) {
        print("PAN gesture was recognized")
        guard let recognizerView = recognizer.view as? Shape, let superView = recognizerView.superview else { return }
        let translation = recognizer.translation(in: superView)
        switch recognizer.state {
        case .began:
            gravity.removeItem(recognizerView)
        case .changed:
            recognizerView.shapeType == .square ? reboundSquare.removeItem(recognizerView) : reboundCircle.removeItem(recognizerView)
            collision.removeItem(recognizerView)
            recognizerView.center = CGPoint(x: recognizerView.center.x + translation.x, y: recognizerView.center.y + translation.y)
            recognizer.setTranslation(.zero, in: superView)
            animator.updateItem(usingCurrentState: recognizerView)
            collision.addItem(recognizerView)
            recognizerView.shapeType == .square ? reboundSquare.addItem(recognizerView) : reboundCircle.addItem(recognizerView)
        case .ended:
            gravity.addItem(recognizerView)
        default:
            break
        }
    }
    
    @objc func pinchGestureHandle(recognizer: UIPinchGestureRecognizer) {
        print("PINCH gesture was recognized")
        guard let recognizerView = recognizer.view as? Shape, let superView = recognizerView.superview else { return }
        switch recognizer.state {
        case .began:
            gravity.removeItem(recognizerView)
        case .changed:
            recognizerView.shapeType == .square ? reboundSquare.removeItem(recognizerView) : reboundCircle.removeItem(recognizerView)
            collision.removeItem(recognizerView)
            let changedWidth = recognizerView.layer.bounds.size.width * recognizer.scale
            let changedHeight = recognizerView.layer.bounds.size.height * recognizer.scale
            if (changedWidth < superView.bounds.width - 50 && changedHeight < superView.bounds.height - 50)
                && (changedWidth > 50 && changedHeight > 50) {
                recognizerView.layer.bounds.size.width = changedWidth
                recognizerView.layer.bounds.size.height = changedHeight
                recognizer.scale = 1.0
            }
            collision.addItem(recognizerView)
            recognizerView.shapeType == .square ? reboundSquare.addItem(recognizerView) : reboundCircle.addItem(recognizerView)
        case .ended:
            gravity.addItem(recognizerView)
        default:
            break
        }
    }
    
    @objc func rotationGestureHandle(recognizer: UIRotationGestureRecognizer) {
        print("TAP gesture was recognized")
        guard let recognizerView = recognizer.view as? Shape else { return }
        switch recognizer.state {
        case .began:
            gravity.removeItem(recognizerView)
        case .changed:
            recognizerView.shapeType == .square ? reboundSquare.removeItem(recognizerView) : reboundCircle.removeItem(recognizerView)
            collision.removeItem(recognizerView)
            recognizerView.transform = recognizerView.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
            animator.updateItem(usingCurrentState: recognizerView)
            collision.addItem(recognizerView)
            recognizerView.shapeType == .square ? reboundSquare.addItem(recognizerView) : reboundCircle.addItem(recognizerView)
        case .ended:
            gravity.addItem(recognizerView)
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(.all)
    }

}

