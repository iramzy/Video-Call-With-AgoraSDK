//
//  MainViewController.swift
//  Agora | video Conferance
//
//  Created by Ahmed Ramzy on 4/6/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func joinIsPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let callViewController = storyboard.instantiateViewController(withIdentifier: "CallVC") as! CallViewController
        present(callViewController, animated: true, completion: nil)
    }
}
