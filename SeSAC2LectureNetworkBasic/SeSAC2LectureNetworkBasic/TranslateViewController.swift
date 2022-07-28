//
//  TranslateViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/28.
//

import UIKit

//UIButton, UITextField 등 > Action O
//UITextView, UISearchBar, UIPickerView 등 > Action X
//Why??
//UIControl
//UIResponderChain > resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var userInputTextView: UITextView!
    
    let textViewPlaceholder = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        //플레이스 홀더 만들어보기
        userInputTextView.text = textViewPlaceholder
        userInputTextView.textColor = .lightGray
    }
    

}


extension TranslateViewController: UITextViewDelegate {
    
    //텍스트 뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
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
