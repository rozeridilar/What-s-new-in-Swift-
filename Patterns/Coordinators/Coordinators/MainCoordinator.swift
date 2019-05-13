//
//  MainCoordinator.swift
//  Coordinators
//
//  Created by Kızılay on 13.05.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator{
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func buySubscription(){
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func createAccount(){
        let vc = CreateAccountViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
