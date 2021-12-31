//
//  HomeViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/01.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa
import NSObject_Rx

class HomeViewController: UIViewController {
    
    private let searchAPI = SearchAPI()
    
    @IBOutlet weak var playButton: UIButton!
    
    var awardRecommendListViewController: RecommendListViewController!
    var hotRecommendListViewController: RecommendListViewController!
    var myRecommendListViewController: RecommendListViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "award" {
            let destinationVC = segue.destination as? RecommendListViewController
            awardRecommendListViewController = destinationVC
            awardRecommendListViewController.viewModel.updateType(.award)
            awardRecommendListViewController.viewModel.fetchItems()
        } else if segue.identifier == "hot" {
            let destinationVC = segue.destination as? RecommendListViewController
            hotRecommendListViewController = destinationVC
            hotRecommendListViewController.viewModel.updateType(.hot)
            hotRecommendListViewController.viewModel.fetchItems()
        } else if segue.identifier == "my" {
            let destinationVC = segue.destination as? RecommendListViewController
            myRecommendListViewController = destinationVC
            myRecommendListViewController.viewModel.updateType(.my)
            myRecommendListViewController.viewModel.fetchItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.rx.tap
            .withLatestFrom(searchAPI.search("interstellar"))
            .compactMap { $0.first }
            .observe(on: MainScheduler.asyncInstance)
            .bind { movie in
                let sb = UIStoryboard(name: "Player", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                let url = URL(string: movie.previewURL ?? "")!
                let item = AVPlayerItem(url: url)
                vc.rendering(item: item)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: rx.disposeBag)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 확인
        UserDefaultsManager.shared.dbRepresentation(key: .initialLaunchKey)
        UserDefaultsManager.shared.dbRepresentation(key: .thresholdKey)
        UserDefaultsManager.shared.dbRepresentation(key: .query)
    }
    
}
