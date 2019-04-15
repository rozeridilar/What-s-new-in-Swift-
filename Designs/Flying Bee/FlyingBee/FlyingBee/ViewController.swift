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

