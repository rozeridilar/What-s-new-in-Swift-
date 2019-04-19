//
//  ViewController.swift
//  UIViewAnimations
//
//  Created by Kızılay on 19.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var RyuImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage]{
        var imageArray: [UIImage] = []
        for index in 0..<total{
            imageArray.append(UIImage(named: "\(imagePrefix)_\(index).png")!)
        }
        return imageArray
    }


}

