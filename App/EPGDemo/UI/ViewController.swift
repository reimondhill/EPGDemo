//
//  ViewController.swift
//  EPGDemo
//
//  Created by Ramon Haro Marques on 21/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EPGFetcher().getEPG(daysOffset: 0) { (result) in
            switch result {
            case .success(_):
                print("yeah")
            case .failure(let error):
                print(error)
            }
        }
    }


}

