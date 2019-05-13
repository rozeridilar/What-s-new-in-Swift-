//
//  Coordinator.swift
//  Coordinators
//
//  Created by Kızılay on 13.05.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController{ get set }
    
    func start()
    
}
