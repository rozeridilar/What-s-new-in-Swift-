//
//  ViewController.swift
//  Interactive 3D Carousel with Core Animation
//
//  Created by Kızılay on 8.04.2019.
//  Copyright © 2019 Turk Kizilay. All rights reserved.
//

import UIKit

enum Capitals: String, CaseIterable{
    case amsterdam = "amsterdam",london = "london",budapest = "budapest",ankara = "ankara",madrid = "madrid",paris = "paris",rome = "rome"
}

func degreeToRadians(_ deg: CGFloat) -> CGFloat{
    return (deg * CGFloat.pi) / 180
}

class ViewController: UIViewController {

    //container for all of our image cards
    let transformLayer = CATransformLayer()
    
    //rotate to our image cards
    var currentAngle:CGFloat = 0
    
    //store the offset of our pan gesture recognizer
    var currentOffset: CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Capitals.allCases.forEach{
            addImageCard(name: $0.rawValue)
        }
        
        turnCrousel()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.performPanAction(recognizer:)))
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        transformLayer.frame = self.view.bounds
        view.layer.addSublayer(transformLayer)
    }
    
    func addImageCard(name: String){
        let imageCardSize = CGSize(width: self.view.bounds.width - 200, height: 300)
        
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: self.view.frame.width / 2 - imageCardSize.width / 2, y: self.view.frame.height / 2 - imageCardSize.height / 2, width: imageCardSize.width, height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5 , y: 0.5)
        
        guard let imageCard = UIImage(named: name)?.cgImage else{return}
        
        imageLayer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        imageLayer.borderWidth = 5
        imageLayer.cornerRadius = 10
        
        imageLayer.contents = imageCard
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.masksToBounds = true
        
        imageLayer.isDoubleSided = true
        
        transformLayer.addSublayer(imageLayer)
        
    }
    
    func turnCrousel(){
        guard let transformSublayers = transformLayer.sublayers else {return}
        
        let segmentForImageCard = CGFloat( 360 / transformSublayers.count)
        
        var angleOffset = currentAngle
        
        for layer in transformSublayers{
            var transform = CATransform3DIdentity
            transform.m34 = -1/500
            
            transform = CATransform3DRotate(transform, degreeToRadians(angleOffset), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, self.view.bounds.width - 170)
            
            CATransaction.setAnimationDuration(0)
            
            layer.transform = transform
            
            angleOffset += segmentForImageCard
        }
    }
    
    @objc func performPanAction(recognizer: UIPanGestureRecognizer){
        let xOffset = recognizer.translation(in: self.view).x
        
        if recognizer.state == .began{
            currentOffset = 0
        }
        
        let xDiff = xOffset * 0.6 - currentOffset
        
        currentOffset += xDiff
        currentAngle += xDiff
        
        turnCrousel()
    }
}

