//
//  ImageSearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageSearchCollectionView.delegate = self
        imageSearchCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        imageSearchCollectionView.collectionViewLayout = layout

        
        fetchImage()
        
    }
    
    
    //fetchImage, requestImage, callRequestImage, getImage...> response에 따라 네이밍을 설정해주기도 함.
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1" //왜 한글만 안되지? => UTF-8로 인코딩
                
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        

        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["items"].arrayValue {
                    self.list.append(item["link"].stringValue)
                    
                    //20개 셀
                    
                    //셀에서 URL, UIImage 변환을 할 건지 =>
                    //서버통신 받는 시점에서 URL, UIImage 변환을 할 건지 => 시간 오래 걸림
                }
                
                self.imageSearchCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as! ImageSearchCollectionViewCell
        
        let url = URL(string: list[indexPath.item])
        cell.imageView.kf.setImage(with: url)
        cell.imageView.backgroundColor = .lightGray
        return cell
        
    }


}
