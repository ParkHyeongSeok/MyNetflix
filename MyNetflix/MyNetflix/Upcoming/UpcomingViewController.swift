//
//  UpcomingViewController.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/30.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "awards" {
            let destinationVC = segue.destination as? RecommendListViewController
            destinationVC?.viewModel.updateType(.award)
            destinationVC?.viewModel.fetchItems()
        } else if segue.identifier == "hots" {
            let destinationVC = segue.destination as? RecommendListViewController
            destinationVC?.viewModel.updateType(.hot)
            destinationVC?.viewModel.fetchItems()
        }
    }
    
}
