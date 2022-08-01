//
//  SearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/27.
//

import UIKit

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔
 2. 테이블 뷰 아울렛 연결
 3. 1 + 2
 */

extension UIViewController {
    
    func setBackgroundColor() {
        view.backgroundColor = .orange
    }
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.backgroundColor = .clear

        //연결고리 작업: 테이블 뷰가 해야 할 역할 => 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블 뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB: Xml Interface Builder <= NIB
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }
    
//    func configureView() {
//        searchTableView.backgroundColor = .clear
//        searchTableView.separatorColor = .clear
//        searchTableView.rowHeight = 60
//    }
//
//    func configureLabel() {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO JOONGWON"
        
        return cell
    }

}
