//
//  ViewController.swift
//  ParallaxMotionEffecr
//
//  Created by Kızılay on 17.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var monkey_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyMotionEffect(toView: backgroundImageView, magnitude: 10)
        applyMotionEffect(toView: monkey_image, magnitude: -20)
    }
    
    func applyMotionEffect(toView view: UIView, magnitude: Float){
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.maximumRelativeValue = magnitude
        xMotion.minimumRelativeValue = -magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.maximumRelativeValue = magnitude
        yMotion.minimumRelativeValue = -magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion,yMotion]
        
        view.addMotionEffect(group)
    }


}

