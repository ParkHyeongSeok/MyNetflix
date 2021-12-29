//
//  SearchApiType.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/29.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchApiType {
    func search(_ query: String) -> Observable<[Movie]>
}
