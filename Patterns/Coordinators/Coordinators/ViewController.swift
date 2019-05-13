//
//  ViewController.swift
//  Coordinators
//
//  Created by Kızılay on 13.05.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buyTapped(_ sender: Any) {
        coordinator?.buySubscription()
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        coordinator?.createAccount()
    }
}

