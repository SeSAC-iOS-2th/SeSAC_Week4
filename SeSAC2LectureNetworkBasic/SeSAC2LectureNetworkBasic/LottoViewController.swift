//
//  LottoViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON


class LottoViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView() //코드로 뷰를 짜는 기능이 훨씬 더 많이 남아있다!!
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.textContentType = .oneTimeCode //인증번호
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView //텍스트 필드를 클릭할 때, 키보드가 올라오는 것을 방지
        
        lottoPickerView.dataSource = self
        lottoPickerView.delegate = self
        
        requestLotto(number: 1025)
    }
    
    func requestLotto(number: Int) {
        
        //AF: 200~299 status code 성공
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].intValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }

    
}
