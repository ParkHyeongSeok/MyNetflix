//
//  PlayerViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/01.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    let avplayer = AVPlayer()
    
    // 화면 방향 설정
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        playButton.rx.tap
            .bind(onNext: {
                self.playButton.isSelected.toggle()
            })
            .disposed(by: rx.disposeBag)
    }
    

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
