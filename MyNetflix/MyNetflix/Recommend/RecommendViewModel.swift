//
//  RecommendViewModel.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/29.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RecommentListViewModel {
    
    private(set) var type: RecommendingType = .my
    private var items: [DummyItem] = []
    
    var numOfItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> DummyItem {
        return items[index]
    }
    
    func updateType(_ type: RecommendingType) {
        self.type = type
    }
    
    func fetchItems() {
        self.items = MovieFetcher.fetch(type)
    }
}

enum RecommendingType {
    case award
    case hot
    case my
    
    var title: String {
        switch self {
        case .award: return "아카데미 호평 영황"
        case .hot: return "취한저격 HOT 콘텐츠"
        case .my: return "내가 찜한 콘텐츠"
        }
    }
}
