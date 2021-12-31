//
//  UserDefaultsManager.swift
//  MyNetflix
//
//  Created by 박형석 on 2021/12/31.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import Foundation
import RxSwift

class UserDefaultsManager: UserDefaultsManagerType {
    static let shared = UserDefaultsManager()
    typealias KEY = DataKey
    typealias VALUE = String
    enum DataKey: String {
        // 영화 검색어 저장 키
        case query
        // 가상의 설정 데이터 저장키
        case thresholdKey
        // 최초 실행시점 판단키
        case initialLaunchKey
    }
    
    private let db = UserDefaults.standard
    
    func save(key: KEY, value: [VALUE]) {
        // 이미 값이 있다면 값을 교체, 아니면 추가
        var quries = self.read(key: key) ?? []
        quries += value
        db.set(quries, forKey: key.rawValue)
        // 예전에는 UserDefaults.standard.synchronize() 사용했는데 지금은 X
    }
    
    func read(key: KEY) -> [VALUE]? {
        // 우리가 받아오고자 하는 데이터 형식이 메소드
        // key 해당하는 값이 있으면 리턴 없으면 nil
        // bool과 숫자는 false, 0 리턴
        // 저장 값을 다른 타입으로 불러와도 최대한 변환해서 리턴
        // ex) 실수 -> 정수, 하지만 좋은 거라고 보기 어려움... 제대로 리턴하도록
        return db.array(forKey: key.rawValue) as? [VALUE]
    }
    
    func delete(key: KEY) {
        // 1. setForKey
        db.set(nil, forKey: key.rawValue)
        // 2. removeObjectForkey
        db.removeObject(forKey: key.rawValue)
    }
    
    func initialSetting(_ defaultValues: Any) {
        if !db.bool(forKey: DataKey.initialLaunchKey.rawValue) {
            self.defaultSetting(defaultValues)
            db.set(true, forKey: DataKey.initialLaunchKey.rawValue)
            print("initial Setting")
        }
    }
    
    private func defaultSetting(_ value: Any) {
        // 기본값들 변환
        let settingDic = [DataKey.thresholdKey.rawValue:value]
        // 다수의 기본값 한번에 등록하기, 딕셔너리
        db.register(defaults: settingDic)
    }
    
    func dbRepresentation(key: KEY) {
        // 우리가 저장한 값 뿐만 아니라 시스템이 내부적으로 저장한 데이터도 저장
        // print(db.dictionaryRepresentation())
        
        // 우리가 저장한 값만 보기, 확인할 key를 배열로 전달하기
        print(db.dictionaryWithValues(forKeys: [key.rawValue]))
    }
    
}
