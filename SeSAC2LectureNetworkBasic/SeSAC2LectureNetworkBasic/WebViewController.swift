//
//  WebViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 이중원 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
        
    var destinationURL: String = "https://www.apple.com"
    //ATS Transport Security Settings
    //http X

    override func viewDidLoad() {
        super.viewDidLoad()

        openWebPace(to: destinationURL)
        searchBar.delegate = self
        

    }
    
    func openWebPace(to url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }


    @IBAction func goBackButtonClicked(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIButton) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPace(to: searchBar.text!)
    }
}
