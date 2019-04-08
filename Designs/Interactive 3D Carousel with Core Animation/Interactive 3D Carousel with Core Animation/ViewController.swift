//
//  ViewController.swift
//  Interactive 3D Carousel with Core Animation
//
//  Created by Kızılay on 8.04.2019.
//  Copyright © 2019 Turk Kizilay. All rights reserved.
//

import UIKit

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
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.performPanAction(recognizer:)))
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func performPanAction(recognizer: UIPanGestureRecognizer){
        
    }
}

