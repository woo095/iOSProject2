//
//  ViewController.swift
//  ImageViewAnimation
//
//  Created by Sinchon on 2021/04/21.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    //애니메이션에 사용할 이미지 배열
    var imgArray = [UIImage]()
    //현재 출력중인 이미지의 인덱스
    var i:Int?
    //애니메이션 속도
    var speed:Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgArray.append(UIImage(named:"red0.jpg")!)
        imgArray.append(UIImage(named:"red1.jpg")!)
        imgArray.append(UIImage(named:"red2.jpg")!)
        imgArray.append(UIImage(named:"red3.jpg")!)
        imgArray.append(UIImage(named:"red4.jpg")!)
        
        i = 0
        
        speed = 0.5
        
        //이미지 뷰 초기화
        image.image = imgArray[i!]
        image.animationImages = imgArray
        
    }
    
    
    @IBAction func goPlay(_ sender: Any) {
        //애니메이션 중지 중인지 확인
        if image.isAnimating == false{
            //애니메이션 시간 설정
            image.animationDuration = TimeInterval(Int(speed! * 5) * imgArray.count)
            //애니메이션 시작
            image.startAnimating()
            //버튼의 타이틀 변경
            (sender as! UIButton).setTitle("중지", for: .normal)
        }else {
            //애니메이션 시작
            image.stopAnimating()
            //버튼의 타이틀 변경
            (sender as! UIButton).setTitle("시작", for: .normal)        }
        
    }
    @IBAction func goPrev(_ sender: Any) {
        i = i! - 1
        if i! < 0{
            i = imgArray.count - 1
        }
        image.image = imgArray[i!]
    }
    @IBAction func goNext(_ sender: Any) {
        i = i! + 1
        if i! == imgArray.count{
            i = 0
        }
        image.image = imgArray[i!]
    }
    @IBAction func changeSpeed(_ sender: Any) {
        speed = slider.value
        if image.isAnimating == true{
            image.stopAnimating()
            
            //애니메이션 시간 설정
            image.animationDuration = TimeInterval(Int(speed! * 5) * imgArray.count)
            //애니메이션 시작
            image.startAnimating()        }
    }


}

