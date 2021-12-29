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
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "award" {
            let destinationVC = segue.destination as? RecommendListViewController
            awardsRecommendListViewController = destinationVC
            awardsRecommendListViewController.viewModel.updateType(.award)
            awardsRecommendListViewController.viewModel.fetchItems()
        } else {
            let destinationVC = segue.destination as? RecommendListViewController
            hotsRecommendListViewController = destinationVC
            hotsRecommendListViewController.viewModel.updateType(.hot)
            hotsRecommendListViewController.viewModel.fetchItems()
        }
    }
    
}
