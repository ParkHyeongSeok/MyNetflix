//
//  UserDefaultsManagerType.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/31.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation

protocol UserDefaultsManagerType {
    associatedtype KEY
    associatedtype VALUE
    func save(key: KEY, value: [VALUE])
    func read(key: KEY) -> [VALUE]?
}
