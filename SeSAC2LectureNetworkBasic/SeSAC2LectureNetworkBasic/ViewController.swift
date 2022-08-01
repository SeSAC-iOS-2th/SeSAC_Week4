//
//  ViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresantableProtocol{
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return .blue
        }
    }
    
    static let identifier: String = "ViewController"
    
    
    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치"
//        backgroundColor = .red
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        
        title = UserDefaultsHelper.standard.nickname
        
        UserDefaultsHelper.standard.age = 23
        
        print(UserDefaultsHelper.standard.age)
    }

}

