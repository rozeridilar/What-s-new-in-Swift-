//
//  ViewController.swift
//  FlyingBee
//
//  Created by Kızılay on 15.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SKView!
    
    var scene: BeeScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
      //  let tapGesture = UITapGestureRecognizer(target: self, action:
      //      #selector(handleTap(_:)))
     //   sceneView.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        // retrieve the SCNView
        let scnView = self.sceneView
        
//        // check what nodes are tapped
//        let p = gestureRecognize.location(in: scnView)
//       print(p)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scene = BeeScene(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)
    }
    @IBAction func bringTheBees(_ sender: Any) {
        guard let scene = self.scene else {
            return
        }
        scene.flyBee()
    }
    
}

