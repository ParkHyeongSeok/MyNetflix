//
//  UpcomingViewController.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/30.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    var awardsRecommendListViewController: RecommendListViewController!
    var hotsRecommendListViewController: RecommendListViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "awards" {
            let destinationVC = segue.destination as? RecommendListViewController
            awardsRecommendListViewController = destinationVC
            destinationVC?.viewModel.updateType(.my)
            destinationVC?.viewModel.fetchItems()
        } else if segue.identifier == "hots" {
            let destinationVC = segue.destination as? RecommendListViewController
            hotsRecommendListViewController = destinationVC
            destinationVC?.viewModel.updateType(.award)
            destinationVC?.viewModel.fetchItems()
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}
