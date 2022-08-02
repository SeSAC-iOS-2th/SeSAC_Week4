//
//  BeerViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var beerCollectionView: UICollectionView!
    
    var beerList: [BeerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 2.0)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        beerCollectionView.collectionViewLayout = layout

        
        requestBeer()
        print("맥주 갯수: \(beerList.count)")
    }
    
    func requestBeer() {
        
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for beer in json.arrayValue {
                    let id = beer["id"].intValue
                    let imageURL = URL(string: beer["image_url"].stringValue)
                    let name = beer["name"].stringValue
                    
                    let beerItem = BeerModel(id: id, imageURL: imageURL!, name: name)

                    self.beerList.append(beerItem)
                }
                                
                self.beerCollectionView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell() }
        
        cell.beerIdLabel.text = "(\(String(beerList[indexPath.item].id)))"
        cell.beerImageView.downloadImage(from: beerList[indexPath.item].imageURL)
        cell.beerNameLabel.text = beerList[indexPath.item].name
        cell.beerNameLabel.textAlignment = .center
        
        cell.backgroundColor = .yellow
    
        return cell
    }

}

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url){
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }

        }
    }
}

