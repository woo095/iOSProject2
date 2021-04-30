//
//  MovieLinkVC.swift
//  AlamofireMovieList
//
//  Created by Sinchon on 2021/04/30.
//

import UIKit
import WebKit

class MovieLinkVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    //상위 뷰 컨트롤러에서 데이터를 넘겨받을 프로퍼티
    var link : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let addr = link{
            let url = URL(string: addr)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
