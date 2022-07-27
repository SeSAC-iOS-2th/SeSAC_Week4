import UIKit

//7.26 Grammar Class

//struct Poster {
//    //구조체를 인스턴스로 생성을 해야만, 그 인스턴스를 통해서 image 프로퍼티에 접근 가능
//    var image: UIImage = UIImage(named: "star") ?? UIImage()
//
//    //어떻게 init 초기화 구문을 작성할 수 있는 걸까요?
//    //멤버와이즈 이니셜라이저를 갖고 있지만, 추가적인 구현도 가능하다!
//    //필요에 따라 초기화 구문을 여러 가지로 만들어서 사용할 수 있다!
//    //메서드 오버로딩 특성을 활용해 하나의 초기화 구문인데 여러 구문처럼 쓸 수도 있다!
//    init() {
//        print("Poster Initialized")
//    }
//
//    init(defaultImage: UIImage) {
//        self.image = defaultImage
//    }
//
//    init(customImage: UIImage? = UIImage(named: "star")) {
//        self.image = customImage!
//    }
//}
//
////인스턴스마다 image 프로퍼티가 다른 값을 가질 수 있을까요? OK
//var one = Poster()
//one.image = UIImage(named: "happy")!
//var two = Poster()
//var three = Poster()





////인스턴스 생성 여부와 상관없이 타입 프로퍼티의 값은 하나다!
//
//struct User {
//    static var originalName = "진짜이름" //타입 저장 프로퍼티
//    var nickname = "닉네임" //인스턴스 저장 프로퍼티
//}
//
//var user1 = User()
//user1.nickname = "눈을 감자"
//User.originalName = "오레오"
//print(user1.nickname, User.originalName)
//
//var user2 = User()
//print(user2.nickname, User.originalName)
//
//
//var user3 = User()
//print(user3.nickname, User.originalName)
//
//
//var user4 = User()
//print(user4.nickname, User.originalName)
//
//
//
/*
 연산 프로퍼티(인스턴스 연산 프로퍼티 / 타입 연산 프로퍼티)
 */

struct BMI {
    //이니셜라이저로 초기화가 되기 때문에 oldValue가 존재!, 오류가 생기지 x
    var nickname: String {
        willSet(newNickname) {
            print("유저 닉네임이 \(nickname)에서 \(newNickname)로 변경될 예정이에여")
        }
        didSet {
            print("유저 닉네임 변경 완료!!! \(oldValue) -> \(nickname)으로 바뀜")
        }
    }
    var weight: Double
    var height: Double

    //저장 프로퍼티는 메모리 O, 연산 프로퍼티는 저장 프로퍼티를 활용해서 원하는 값을 반호나하는 용도로 주로 사용!
    //읽기 전용(read-only) 프로퍼티이지만 계산하는 값에 따라 결과가 다 달라질 수 있기 때문!
    var BMIResult: String {
        get {
            let bmiValue = (weight * weight) / height
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            return "\(nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"
        }
        set {
            nickname = newValue
        }
    }
}

var bmi = BMI(nickname: "고래밥", weight: 67, height: 183)

//let bmiValue = (bmi.weight * bmi.weight) / bmi.height
//let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
//let result = "\(bmi.nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"

let result = bmi.BMIResult //String
print(result)

bmi.BMIResult = "올라프"
print(bmi.BMIResult)



//class FoodRestaurant {
//    let name = "중치킨"
//    var totalOrderCount = 10 //총 주문건수
//
//    var nowOrder: Int {
//        get {
//            return totalOrderCount * 5000
//        }
//        set {
//            totalOrderCount += newValue //기본 파라미터 newValue
//        }
//    }
//}
//
//let food = FoodRestaurant()
//
//print(food.nowOrder)
//
////food.totalOrderCount += 5
////food.totalOrderCount += 20
////food.totalOrderCount += 100
//
////label text vs button currentTitle
//
//food.nowOrder = 5
//print(food.nowOrder)
//
//food.nowOrder = 20
//print(food.nowOrder)
//
//food.nowOrder = 100
//print(food.nowOrder)
//
//
//
////열거형은 타입 자체 > 인스턴스 생성이 불가능하다 > 초기화 구문 X
////인스턴스 생성을 통해서 접근할 수 있는 인스턴스 저장 프로퍼티 사용 불가! 인스턴스 연산 프로퍼티는? 쓸 수 있다!
////메모리의 관점 + 열거형이 컴파일 타임에 확정되어야 한다! > 인스턴스 연산 프로퍼티는 열거형에서 사용할 수 없다....
//enum ViewType {
//    case start
//    case change
//
//    //var nickname: String = "고래밥"
//
//
//    var nickname: String {
//
//        return "a"
//    }
//
//    static var title = "시작하기"
//}
//
////타입 프로퍼티는 인스턴스랑 상관없이 접근 가능! > 따라서 열거형에서 타입 저장 프로퍼티, 타입 연산 프로퍼티는 모두 사용 가능!
////인스턴스 저장 프로퍼티는 메모리에, 값이 달라질 수 있음 > X > 열거형은 초기화 구문읆 만들 수 없기 때문입니다.
//
////타입 저장 프로퍼티, 타입 연산 프로퍼티, 인스턴스 저장 프로퍼티, 인스턴스 연산 프로퍼티



//7.27 grammar class

class TypeFoodRestaurant {
    
    static let name = "중치킨" //타입 상수 저장 프로퍼티
    static var totalOrderCount = 10 {
        willSet { //변경 되기 직전에 실행
            print("총 주문 건수가 \(totalOrderCount)에서 \(newValue)로 변경될 예정입니다.")
        }
        didSet { //변경 되고난 직후에 실행
            print("총 주문 건수가 \(oldValue)에서 \(totalOrderCount)로 바뀌었습니다.")
        }
    }
    
    static var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set {
            totalOrderCount += newValue //기본 파라미터 newValue, 변경 가능!
        }
    }

}

TypeFoodRestaurant.nowOrder //타입 연산 프로퍼티 Get

TypeFoodRestaurant.nowOrder = 15 //타입 연산 프로퍼티 Set, totalOrderCount 값이 바뀌기 때문에 willSet, didSet이 실행

TypeFoodRestaurant.nowOrder

//Property Observer: 저장 프로퍼티에서 주로 사용되고, 저장 프로퍼티 값을 관찰을 하다가 변경이 될 것 같을 때, 또는 변경이 되었을 때 호출됨! (willSet / didSet)



//메서드: 타입 메서드 & 인스턴스 메서드
//타입은 타입끼리, 인스턴스는 인스턴스끼리 노는 것

struct Coffee {
    static var name = "아메리카노"
    static var shot = 2
    var price = 4900
    
    mutating func plusShot() {
//        shot += 1
        price += 300
    }
    
    //타입 메서드를 오버라이딩 가능하게 하고 싶다면 static 대신 class 키워드 사용
    static func minusShot() {
        shot -= 1
    }
}

//class Latte: Coffee {
//    override class func minusShot() { //슈퍼클래스의 타입 메서드를 재정의해서 쓰고 싶다면 class!
//        <#code#>
//    }
//}







