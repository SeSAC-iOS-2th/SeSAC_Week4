//
//  TranslateViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

//UIButton, UITextField 등 > Action O
//UITextView, UISearchBar, UIPickerView 등 > Action X
//Why??
//UIControl
//UIResponderChain > resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!
    
    @IBOutlet weak var userInputLanguageLabel: UILabel!
    @IBOutlet weak var translateLanguageLabel: UILabel!
    
    let textViewPlaceholder = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        //플레이스 홀더 만들어보기
        userInputTextView.text = textViewPlaceholder
        userInputTextView.textColor = .lightGray
        
        //Custom Font 쓰기
        userInputTextView.font = UIFont(name: "ChosunCentennial", size: 17)
        
        userInputLanguageLabel.text = "(한국어)"
        translateLanguageLabel.text = "(영어)"
        
        }
    
    func requestTranslateData(text: String) {
        
        let url = EndPoint.translateURL
        
        let parameter = ["source": "ko", "target": "en", "text": text]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        if userInputTextView.textColor != .lightGray && userInputTextView.text != nil {
            AF.request(url, method: .post, parameters: parameter, headers: header).validate(statusCode: 200...500).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")

                    self.translateTextView.text = json["message"]["result"]["translatedText"].stringValue
                    self.translateTextView.font = UIFont(name: "ChosunCentennial", size: 17)

    //                let statusCode = response.response?.statusCode ?? 500
    //
    //                if statusCode == 200 {
    //
    //                } else {
    //                    self.userInputTextView.text = json["errorMessage"].stringValue
    //                }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        requestTranslateData(text: userInputTextView.text)
    }
}


extension TranslateViewController: UITextViewDelegate {
    
    //텍스트 뷰의 텍스트가 변할 때마다 호출
//    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text.count)
//    }
    
    //편집이 시작될 때, 커서가 시작될 때
    //텍스트 뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color 변경
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝났을 때, 커서가 없어지는 순간
    //텍스트 뷰 글자: 사용자가 아무 글자도 쓰지 않았으면 플레이스 홀더 글자 보이게 하도록
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        }
    }
}
