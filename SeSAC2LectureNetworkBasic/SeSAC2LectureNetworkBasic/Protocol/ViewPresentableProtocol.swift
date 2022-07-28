//
//  ViewPresentableProtocol.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/28.
//

import Foundation
import UIKit

/*
 naming:
 ~~~~Protocol
 ~~~~Delegate 등
 */

//프로토콜을 사용하는 이유
//프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다!
//실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다!
//클래스, 구조체, 열거형, 익스텐션 등에 사용됨
//클래스는 단일 상속만 가능, 프로토콜은 채택 갯수에 제한이 없다!
//@objc optional > 선택적 요청(Optional Requirement)
//프로토콜 프로퍼티, 프로토콜 메서드

//프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다!
//명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고 연산 프로퍼티로 사용할 수 있다.
//무조건 var로 선언해야 한다.
@objc protocol ViewPresantableProtocol {
    
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get } //get이라 지정해준 것은 최소한의 구현 사항, set을 구현하는 것도 가능!!
    static var identifier: String { get } //읽기 전용으로 쓰려고 할 때 => get으로 지정, 실제 구현 클래스에서 let으로 설정 가능
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}



/*
 ex. 테이블 뷰
 */

@objc protocol JoongTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
