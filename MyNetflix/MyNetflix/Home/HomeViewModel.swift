//
//  HomeViewModel.swift
//  MyNetflix
//
//  Created by 박형석 on 2022/01/07.
//  Copyright © 2022 com.joonwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    let searchAPI: SearchAPI
    init(searchAPI: SearchAPI) {
        self.searchAPI = searchAPI
    }
    
    var awardMovies: Driver<[Movie]> {
        return searchAPI.fetchRecommendItem(recommendingType: .award).asDriver(onErrorJustReturn: [])
    }
    
    var hotMovies: Driver<[Movie]> {
        return searchAPI.fetchRecommendItem(recommendingType: .hot).asDriver(onErrorJustReturn: [])
    }
    
    var myMovies: Driver<[Movie]> {
        return searchAPI.fetchRecommendItem(recommendingType: .my).asDriver(onErrorJustReturn: [])
    }
    
    func search(_ query: String) -> Observable<[Movie]> {
        return searchAPI.search(query)
    }
    
}
