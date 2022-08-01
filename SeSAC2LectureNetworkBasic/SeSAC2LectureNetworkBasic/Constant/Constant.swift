//
//  Constant.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/08/01.
//

import Foundation

//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}


struct StoryboardName {
    
    //접근제어를 통해 초기화 방지 => 열거형을 쓰는 것과 큰 차이가 없어지게 된다.
    private init() {
        
    }
    
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

/*
 1. struct type property vs enum type property => 인스턴스 생성 방지
 2. enum case vs enum static => 중복된 값을 가질 수 있는지 여부, case 제약 
 */


//enum StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

enum FontName {
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}


