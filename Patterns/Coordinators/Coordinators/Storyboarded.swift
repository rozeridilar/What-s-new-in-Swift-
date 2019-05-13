//
//  Storyboarded.swift
//  Coordinators
//
//  Created by Kızılay on 13.05.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

//default implementation
extension Storyboarded where Self: UIViewController{
    static func instantiate() -> Self{
       let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
