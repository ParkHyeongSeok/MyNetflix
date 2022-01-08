//
//  Movie.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/29.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation

struct NetworkResponse<Wrapper: Codable>: Codable {
    var resultCount: Int?
    var movies: [Wrapper]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let director: String
    let thumbnailPath: String
    let previewURL: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
        case releaseDate = "releaseDate"
    }
}

extension Movie: Comparable {
    static func < (lhs: Movie, rhs: Movie) -> Bool {
        let lhsResult = Date.dateFromISOString(string: lhs.releaseDate) ?? Date()
        let rhsResult = Date.dateFromISOString(string: rhs.releaseDate) ?? Date()
        return lhsResult < rhsResult
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
