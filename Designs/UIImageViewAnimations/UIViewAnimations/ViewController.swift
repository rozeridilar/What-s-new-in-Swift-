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
    @IBOutlet weak var ryuImageView: UIImageView!
    
    var heartImages:[UIImage] = []
    var ryuImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        heartImages = createImageArray(total: 24, imagePrefix: "heart")
        ryuImages = createImageArray(total: 7, imagePrefix: "ryu")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heartImageView.animateImages(imageView: heartImageView, images: heartImages)
        ryuImageView.animateImages(imageView: ryuImageView, images: ryuImages)

    }
    
    
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage]{
        var imageArray: [UIImage] = []
        for index in 0..<total{
            imageArray.append(UIImage(named: "\(imagePrefix)-\(index).png")!)
        }
        return imageArray
    }


}
extension UIImageView{
    func animateImages(imageView: UIImageView, images:[UIImage]){
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        
        //put 0 if you want loop
        imageView.animationRepeatCount = 0
        
        imageView.startAnimating()
    }
}
