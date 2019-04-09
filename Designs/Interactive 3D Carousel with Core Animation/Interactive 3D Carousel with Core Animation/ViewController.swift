//
//  ViewController.swift
//  Interactive 3D Carousel with Core Animation
//
//  Created by Kızılay on 8.04.2019.
//  Copyright © 2019 Turk Kizilay. All rights reserved.
//

import UIKit

enum Capitals: Int, CaseIterable{
    case amsterdam = 0
    ,london = 1
    ,budapest = 2
    //,ankara = "ankara",madrid = "madrid",paris = "paris"
    //,rome = "rome"
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
    let imageCardSize = CGSize(width: 200, height: 300)
    
    var textLayer = {(_ text: String, imageLayer: CALayer) -> CATextLayer in
        let textLayer = CATextLayer()
        
        //What if the string is more than 2 words
        //textLayer.frame.origin.y = imageLayer.frame.origin.y - 70
        
        
        //textLayer.frame.size.height = imageLayer.frame.height / 5
        
        textLayer.frame = CGRect(x: 0, y: imageLayer.frame.origin.y, width: imageLayer.frame.width, height: imageLayer.frame.height/3)
        
        textLayer.isDoubleSided = true
        
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.contentsGravity = CALayerContentsGravity.center
        textLayer.name = "Text \(text)"
        textLayer.string = text
        textLayer.font = UIFont(name: "Avenir-Light", size: 15.0)
        
        return textLayer
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Capitals.allCases.forEach{
            addImageCard(name: "\($0)")
        }
        
        turnCrousel()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.performPanAction(recognizer:)))
        
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        transformLayer.frame = self.view.bounds
        view.layer.addSublayer(transformLayer)
    }
    
    func addImageCard(name: String){
        let imageLayer = CALayer()
        
        //width decides how image will fit
        imageLayer.frame = CGRect(x: self.view.frame.size.width / 2 - imageCardSize.width / 2, y: self.view.frame.size.height / 2 - imageCardSize.height / 2, width: imageCardSize.width - 35, height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5 , y: 0.5)
        
        guard let imageCard = UIImage(named: name)?.cgImage else{return}
        
        imageLayer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        imageLayer.borderWidth = 5
        imageLayer.cornerRadius = 10
        
        imageLayer.contents = imageCard
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.masksToBounds = true
        
        imageLayer.name = "Image \(name)"
        
        imageLayer.isDoubleSided = true
        
        imageLayer.addSublayer(textLayer(name, imageLayer))
        
        transformLayer.addSublayer(imageLayer)
    }
    
    
    func turnCrousel(){
        guard let transformSublayers = transformLayer.sublayers else {return}
        
        let segmentForImageCard = CGFloat( 360 / (transformSublayers.count))
        
        var angleOffset = currentAngle
        
        for layer in transformSublayers{
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            
            transform = CATransform3DRotate(transform, degreeToRadians(angleOffset), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 200)
            
            CATransaction.setAnimationDuration(0)
            
            layer.transform = transform
            angleOffset += segmentForImageCard
        }
    }
    
    var isTurningToLeft: Bool = false
    
    @objc func performPanAction(recognizer: UIPanGestureRecognizer){
        let xOffset = recognizer.translation(in: self.view).x
        
        if recognizer.state == .began{
            currentOffset = 0
        }
        
        let xDiff = xOffset * 0.4 - currentOffset
        
        currentOffset += xDiff
        currentAngle += xDiff
        
        //What If XOffset == 0 ?
        isTurningToLeft = xOffset > 0 ? true : false
        
        turnCrousel()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        // -> 360 / (Capitals.count)
        print("Current Offset \(self.currentOffset)")
        print("Current Angle \(self.currentAngle)")
        let layerAngle = 360 / Capitals.allCases.count
        let variance = 25
        let res = (Int(self.currentAngle)).magnitude
        var maxVal = res.advanced(by: variance)
        var minVal = res.distance(to: UInt(variance))
        
        Capitals.allCases.forEach{
           
            if maxVal.magnitude > 360 {
                maxVal = maxVal.magnitude % 360
            }
            if minVal.magnitude > 360 {
                minVal = Int(minVal.magnitude % 360)
            }
            
            let max = maxVal / layerAngle.magnitude
            let min = (minVal / layerAngle).magnitude
            
   //         if !isTurningToLeft{
            
                if max == $0.rawValue{
                    print("\($0)")
                    return
                }
//            }else{
//                if min == $0.rawValue{
//                    print("\($0)")
//                    return
//                }
//            }
            
        }
    }
    
}

