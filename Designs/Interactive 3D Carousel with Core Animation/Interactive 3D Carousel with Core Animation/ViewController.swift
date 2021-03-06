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
//    ,ankara = 3
//    ,madrid = 4
//    ,paris = 5
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
        //        print("xOffset \(xOffset)")
        //        print("xxDiff \(xDiff)")
        //What If XOffset == 0 ?
        isTurningToLeft = xOffset > 0 ? true : false
        print("Is Turning to left?   \(isTurningToLeft)")
        turnCrousel()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        // -> 360 / (Capitals.count)
        print("Current Offset \(self.currentOffset)")
        print("Current Angle \(self.currentAngle)")
        let layerAngle = 360 / Capitals.allCases.count
        let variance = 25
        let res = (Int(self.currentAngle)).magnitude
        var rightVal = res.advanced(by: variance)
        let totalCount = Capitals.allCases.count
        var tappedElement = ""
        Capitals.allCases.forEach{
            if rightVal.magnitude > 360 {
                rightVal = rightVal.magnitude % 360
            }
            let max = rightVal / layerAngle.magnitude
            
            if max == $0.rawValue{
                if !isTurningToLeft{
                    //print("Right \($0)")
                    tappedElement = currentAngle < 0 ? "\($0)" : $0.rawValue == 2 ? "\(Capitals.allCases[1])" : $0.rawValue == 1 ?
                        "\(Capitals.allCases[2])" : "\($0)"
                    return
                }else{
                    if totalCount % 2 == 0 && ($0.rawValue == 0 || $0.rawValue == totalCount/2) {
                        //print("Left \($0)")
                        tappedElement = "\($0)"
                        return
                    }else{
                        //print("STG WRONG \($0)")
                        #warning("For 3 Values Only")
                        tappedElement = currentAngle < 0 ? "\($0)" : $0.rawValue == 2 ? "\(Capitals.allCases[1])" : $0.rawValue == 1 ?
                        "\(Capitals.allCases[2])" : "\($0)"
                       
                    }
                }
            }
        }
        print(tappedElement)
        self.showAlert(isTurningToLeft ? "Left Direction" : "Right Direction", tappedElement)
    }
    
    func showAlert(_ head: String, _ message: String){
        guard message.count > 1 else{
            return
        }
        
        let alert = UIAlertController(title: head, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

