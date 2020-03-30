//
//  ViewController.swift
//  UnfoundTowns
//
//  Created by Zoh on 7/20/19.
//  Copyright © 2019 Zoh Weiss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var round: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        round.layer.cornerRadius = 35
        // Do any additional setup after loading the view, typically from a nib.
    }


}

