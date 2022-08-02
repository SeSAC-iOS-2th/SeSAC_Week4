//
//  SearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔
 2. 테이블 뷰 아울렛 연결
 3. 1 + 2
 */

/*
 
 각 json value ->
 
 */

extension UIViewController {
    
    func setBackgroundColor() {
        view.backgroundColor = .orange
    }
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    let calendar = Calendar.current
    let today = Date()
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)
        
        let yesterdayYearText = String(calendar.dateComponents([.year], from: yesterday!).year!)
        let yesterdayMonth = calendar.dateComponents([.month], from: yesterday!).month!
        let yesterdayMonthText: String = yesterdayMonth / 10 == 0 ? "0\(yesterdayMonth)" : "\(yesterdayMonth)"
        let yesterdayDay = calendar.dateComponents([.day], from: yesterday!).day!
        let yesterdayDayText: String = yesterdayDay / 10 == 0 ? "0\(yesterdayDay)" : "\(yesterdayDay)"
        
        let yesterdayText = "\(yesterdayYearText)\(yesterdayMonthText)\(yesterdayDayText)"
        
        print(yesterdayText)
        
        searchTableView.backgroundColor = .clear

        //연결고리 작업: 테이블 뷰가 해야 할 역할 => 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블 뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB: Xml Interface Builder <= NIB
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        requestBoxOffice(text: yesterdayText)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }

    func requestBoxOffice(text: String) {
        
        list.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        
        AF.request(url, method: .get).validate().responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //self.list.removeAll() => 통신에 성공했을 때 지울지?
                                                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = movie["rank"].stringValue
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiCnt = movie["audiCnt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(rank: rank, movieTitle: movieNm, releaseDate: openDt, todayCount: audiCnt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                
                //테이블뷰 갱신
                self.searchTableView.reloadData()
                
                print(self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 16)
        cell.titleLabel.text = "\(list[indexPath.row].rank)등: '\(list[indexPath.row].movieTitle)'- 일간 \(list[indexPath.row].todayCount), 누적 \(list[indexPath.row].totalCount)명"
        
        return cell
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) //옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인지 등
    }
    
}
