//
//  ViewController.swift
//  FlyingBee
//
//  Created by Kızılay on 15.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SKView!
    
    var scene: BeeScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //  let tapGesture = UITapGestureRecognizer(target: self, action:
        //      #selector(handleTap(_:)))
        //   sceneView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.beeDestroyedNotf(notification:)), name: Notification.Name(BeeDestroy), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSelectedColor(_:)), name: NSNotification.Name(rawValue: BeeColorNotification), object: nil)

        
        
    }
    // handle notification
    @objc func showSelectedColor(_ notification: NSNotification) {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let color = dict["color"] as? UIColor{
                print("Color is \(color)")
            }
        }
    }
    
    var player: AVAudioPlayer?
    @objc func beeDestroyedNotf(notification: Notification) {
       // playSound()
    }
  
    //    Make sure to change the name of your tune as well as the extension. The file needs to be properly imported (Project Build Phases > Copy Bundle Resources). You might want to place it in assets.xcassets for greater convenience.
    func playSound() {
        guard let url = Bundle.main.url(forResource: "bee_win", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
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

