//
//  QueryViewController.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/31.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class QueryViewController: UIViewController {
    
    @IBOutlet weak var queryTableView: UITableView!
    
    let querySubject = PublishSubject<[String]?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        querySubject
            .compactMap { $0 }
            .bind(to: queryTableView.rx.items(cellIdentifier: "QueryTableViewCell")) {
                indexPath, item, cell in
                cell.textLabel?.text = item
            }
            .disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        querySubject.onNext(UserDefaultsManager.shared.read(key: .query))
    }
}
