//
//  UserDefaultsHelper.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/08/01.
//

import Foundation
import UIKit

class UserDefaultsHelper {
    
    private init() { } //singleton pattern 사용 시, 외부에서 인스턴스 생성하는 것을 방지하기 위한 코드
    
    static let standard = UserDefaultsHelper()
    //singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음

    
    let userDefaults = UserDefaults.standard
        
    enum key: String {
        case nickname, age
    }
    
    var nickname: String? {
        get {
            return userDefaults.string(forKey: key.nickname.rawValue) ?? "대장"
        }
        set { //연산 프로퍼티 parameter
            userDefaults.set(newValue, forKey: key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: key.age.rawValue)
        }
    }
    
}
