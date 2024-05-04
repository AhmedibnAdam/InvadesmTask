//
//  ViewController.swift
//  InvadeTask
//
//  Created by Ahmad on 04/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.pushViewController(ListingRouter.listingModule() , animated: true)
    }
    
}

