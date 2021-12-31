//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import AVFoundation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    let searchAPI = SearchAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.becomeFirstResponder()
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .flatMap(self.searchAPI.search(_:))
            .observe(on: MainScheduler.asyncInstance)
            .do(onNext: { [unowned self] query in
                self.searchBar.resignFirstResponder()
                let text = self.searchBar.text ?? ""
                UserDefaultsManager.shared.save(key: .query, value: [text])
            })
            .bind(to: resultCollectionView.rx.items(cellIdentifier: ResultCollectionViewCell.identifier, cellType: ResultCollectionViewCell.self)) { index, item, cell in
                cell.updateUI(movie: item)
            }
            .disposed(by: rx.disposeBag)
        
        Observable.zip(
            resultCollectionView.rx.itemSelected,
            resultCollectionView.rx.modelSelected(Movie.self))
            .bind { (indexPath: IndexPath, model: Movie) in
                self.resultCollectionView.deselectItem(at: indexPath, animated: false)
                let sb = UIStoryboard(name: "Player", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                guard let url = URL(string: model.previewURL ?? "") else { return }
                let item = AVPlayerItem(url: url)
                vc.rendering(item: item)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: rx.disposeBag)
        
        
        
        resultCollectionView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3 - 10
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
