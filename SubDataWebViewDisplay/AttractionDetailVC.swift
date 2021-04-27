//
//  AttractionDetailVC.swift
//  SubDataWebViewDisplay
//
//  Created by Sinchon on 2021/04/27.
//

import UIKit
import WebKit

private let reuseIdentifier = "Cell"

class AttractionDetailVC: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    //상위 뷰 컨트롤러로부터 데이터를 넘겨받을 프로퍼티
    var webAddress : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let address = webAddress{
            let url = URL(string: address)
            let urlRequest  = URLRequest(url: url!)
            webview.load(urlRequest)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

}
