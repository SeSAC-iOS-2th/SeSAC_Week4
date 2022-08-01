//
//  BeerViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerViewController: UIViewController {

    @IBOutlet weak var beerRecommandButton: UIButton!
    
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerRecommandButton.setTitle("맥주 추천", for: .normal)
        
        recommandBeer()
    }
    
    func recommandBeer() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let name = json["id"].stringValue
                let imageURL = URL(string: json["image_url"].stringValue)
                let description = json["description"].stringValue
                
                
                self.beerNameLabel.text = name
                self.beerImageView.load(url: imageURL!)
                self.beerDescriptionLabel.numberOfLines = 0
                self.beerDescriptionLabel.text = description
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func beerRecommandButtonClicked(_ sender: UIButton) {
        recommandBeer()
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

