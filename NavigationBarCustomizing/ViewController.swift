//
//  ViewController.swift
//  NavigationBarCustomizing
//
//  Created by Sinchon on 2021/05/12.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        
        //기본 속성 이용
        //네비게이션 바의 중앙이나 탭바 아이템에 문자열로 출력됨
        self.title = "타이틀"
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = barButtonItem
        */
        
        /*
        //직접 뷰를 생성해서 네비게이션바에 배치
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        nTitle.numberOfLines = 2
        nTitle.textAlignment = .center
        nTitle.textColor = UIColor.white
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "iOS\nNavigationBarCustomizing"
        
        self.navigationItem.titleView = nTitle
        
        let color = UIColor(red: 0.02, green: 0.5, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = color
        */
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        let image = UIImage(named: "korea.png")
        
        imageView.image = image
        
        self.navigationItem.titleView = imageView
        
        //AlertController에 MapView를 출력해보기
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        let contentVC = UIViewController()
        
        //맵뷰 생성
        let mapKitView = MKMapView(frame:CGRect(x: 0, y: 0, width: 0, height: 0))
        
        //맵뷰를 컨트롤러의 뷰로 설정
        contentVC.view = mapKitView
        
        contentVC.preferredContentSize.height = 300
        
        alert.setValue(contentVC, forKey: "contentViewController")
        
        self.present(alert, animated: true)
    }


}

