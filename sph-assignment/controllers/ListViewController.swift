//
//  ViewController.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class ListsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.shared.fetch { (result) in
            switch result {
            case .success(let feedResult):
                print("feed: \(feedResult)")
            case .failure(let failure):
                print("failure: \(failure)")
            }
        }
        
    }


}

