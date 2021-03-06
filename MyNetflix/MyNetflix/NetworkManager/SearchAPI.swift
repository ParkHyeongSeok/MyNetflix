//
//  SearchAPI.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/29.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchAPI: SearchApiType {
    
    let urlSession = URLSession.shared
    
    func search(_ query: String) -> Observable<[Movie]> {
        guard let request = EndPoint.composeURLRequest(query: query) else { return .empty() }
        return self.urlSession.rx.data(request: request)
            .map { data in
                let response = try JSONDecoder().decode(NetworkResponse<Movie>.self, from: data)
                return response.movies.sorted(by: < )
            }
    }
    
    func fetchRecommendItem(recommendingType: RecommendingType) -> Observable<[Movie]> {
        var query: String!
        switch recommendingType {
        case .my:
            query = "my"
        case .award:
            query = "award"
        case .hot:
            query = "hot"
        }
        let request = URLRequest(url: URL(string: query)!)
        return self.urlSession.rx.data(request: request)
            .map { data in
                let response = try JSONDecoder().decode(NetworkResponse<Movie>.self, from: data)
                return response.movies
            }
    }
}
