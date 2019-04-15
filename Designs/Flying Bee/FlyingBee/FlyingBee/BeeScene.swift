//
//  BeeScene.swift
//  FlyingBee
//
//  Created by Kızılay on 15.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit
import SpriteKit

class BeeScene: SKScene {

    var beeFrames: [SKTexture]?
    
    //you always have to call required initializer if you want to have a ** custom initializer **
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
