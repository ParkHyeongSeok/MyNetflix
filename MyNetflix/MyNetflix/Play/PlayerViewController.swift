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
    
    @IBOutlet weak var playerView: PlayerView!
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
                if self.avplayer.isPlaying {
                    self.pause()
                } else {
                    self.play()
                }
            })
            .disposed(by: rx.disposeBag)
        
        playerView.player = avplayer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        play()
    }
    
    func pause() {
        avplayer.pause()
        self.playButton.isSelected = false
    }
    
    func play() {
        avplayer.play()
        self.playButton.isSelected = true
    }
    
    func reset() {
        pause()
        avplayer.replaceCurrentItem(with: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        reset()
        dismiss(animated: false, completion: nil)
    }
}

extension PlayerViewController {
    func rendering(item: AVPlayerItem) {
        avplayer.replaceCurrentItem(with: item)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
