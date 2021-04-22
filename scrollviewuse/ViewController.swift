//
//  ViewController.swift
//  scrollviewuse
//
//  Created by Sinchon on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //이미지 선언
        let image:UIImage! = UIImage(named: "large.jpg")
        
        //이미지 가져오기
        imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        
        //이미지 크기
        let imageSize = imageView!.frame.size
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = imageSize
        //바운스 속성을 설정
        scrollView.bounces = true
        scrollView.addSubview(imageView)
        
        //이미지 뷰를 현재 뷰 컨트롤러에 배치
        self.view.addSubview(scrollView)
        
        
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self
    }


}

extension ViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

