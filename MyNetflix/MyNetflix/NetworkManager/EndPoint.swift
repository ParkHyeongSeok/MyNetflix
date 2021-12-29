//
//  EndPoint.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/29.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation

struct EndPoint {
    static func composeURLRequest(query: String) -> URLRequest? {
        let BASE_URL = "https://itunes.apple.com/search"
        var components = URLComponents(string: BASE_URL)
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let newQuery = URLQueryItem(name: "term", value: query)
        components?.queryItems = [mediaQuery, entityQuery, newQuery]
        guard let url = components?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
