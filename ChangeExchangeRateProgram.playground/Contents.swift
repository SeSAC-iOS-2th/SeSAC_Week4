import UIKit

//환율 변동 프로그램: 가지고 있는 한국 돈을 현재 환율로 환산할 경우, 미국 달러로 몇 달러인지
//연산 프로퍼티와 프로퍼티 옵저버를 활용
struct ExchangeRate {
    
    var currencyRate: Double {
        willSet {
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet {
            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    
    var USD: Double {
        willSet {
            print("USD willSet - 환전 금액: USD: \(newValue)달러로 환전될 예정")
        }
        didSet {
            print("USD didSet - KRW: \(USD * currencyRate)원 -> \(USD)달러로 환전되었음")
        }
    }
    
    
    var KRW: Double {
        get {
            return Double()
        }
        set {
            USD = newValue / currencyRate
        }
    }
    
    
}



//테스트
var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
