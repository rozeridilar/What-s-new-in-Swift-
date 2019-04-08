//
//  ViewController.swift
//  Interactive 3D Carousel with Core Animation
//
//  Created by Kızılay on 8.04.2019.
//  Copyright © 2019 Turk Kizilay. All rights reserved.
//

import UIKit

enum capitals{
    case amsterdam,london,budapest,ankara,madrid,paris,rome
}

func degreeToRadians(_ deg: CGFloat) -> CGFloat{
    return (deg * CGFloat.pi) / 180
}

class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addImageCard(name: "amsterdam")
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.performPanAction(recognizer:)))
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func addImageCard(name: String){
        let imageCardSize = CGSize(width: 200, height: 300)
        
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: self.view.frame.width / 2 - imageCardSize.width / 2, y: self.view.frame.height / 2 - imageCardSize.height / 2, width: imageCardSize.width, height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5 , y: 0.5)
        
        guard let imageCard = UIImage(named: name)?.cgImage else{return}
        
        imageLayer.contents = imageCard
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.masksToBounds = true
        
        imageLayer.isDoubleSided = true
        
        view.layer.addSublayer(imageLayer)
        
    }
    
    @objc func performPanAction(recognizer: UIPanGestureRecognizer){
        
    }
}

