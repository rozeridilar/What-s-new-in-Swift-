//
//  ViewController.swift
//  iOS Example
//
//  Created by Jin Wang on Feb 8, 2017.
//  Copyright © 2017 Uthoft. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class SimpleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(title: String, imageName: String) {
        titleLabel.text = title + "\n" + "\n"
        imageView.image = UIImage(named: imageName)
    }
}


class CollectionViewController: UICollectionViewController {
    
    @IBOutlet var dismissGesture: UISwipeGestureRecognizer!
    
    @IBOutlet var collection: UICollectionView!
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)? = (LinearCardAttributesAnimator(), false, 1, 1)
    var direction: UICollectionView.ScrollDirection = .horizontal
    
    let cellIdentifier = "SimpleCollectionViewCell"
    
    var collectionArray = [CollectionModel]()
    var collectionDetail = CollectionModel()
    let colors = [964335,734944, 463230, 712217, 345678,245789,998877,711743,162154,305416]
    let images = ["gradient_1","gradient_2","gradient_3","gradient_4","gradient_5","gradient_6","gradient_7","gradient_8"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Turn on the paging mode for auto snaping support.
        collectionView?.isPagingEnabled = true
        
        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = animator?.0
        }
        
        self.changeBackgroundColor()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getNewsData()
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = " "
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSwipeDown(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool { return false }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = c as? SimpleCollectionViewCell {
            let i = indexPath.row % collectionArray.count
            let v = collectionArray[i]
            cell.bind(title: v.title ,imageName: v.url)
            cell.clipsToBounds = animator?.1 ?? true
        }
        print("background color")
        
        self.changeBackgroundColor()
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return view.bounds.size }
        return CGSize(width: view.bounds.width / CGFloat(animator.2), height: view.bounds.height / CGFloat(animator.3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionDetail = self.collectionArray[indexPath.row]
        print("user clicked \(collectionDetail.name)")
        print(indexPath)
    }
  
    
    
    func changeBackgroundColor(){
        //self.collection.backgroundColor = UIColor.init(hex: colors.randomItem!, alpha: 0.9)
        //
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: images.randomElement()!);
        bgImage.contentMode = .scaleToFill
        self.collectionView?.backgroundView = bgImage
    }
    
    //MARK: Networking
    private func getNewsData(){
        self.collectionArray.removeAll()
        
        for n in 1...6{
            var collectionObj = CollectionModel()
            collectionObj.title = "Some Title"
            collectionObj.content = "Some Content"
            collectionObj.name = "Some Name"
            collectionObj.date = "Date"
            collectionObj.url = "Some url"
            collectionObj.id = "\(n)"
            
            self.collectionArray.append(collectionObj)
        }
        
        self.updateNewsData()
    }
    
    //MARK: Update
    func updateNewsData(){
        self.collectionView?.reloadData()
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        clipsToBounds = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}

extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
