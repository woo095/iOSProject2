//
//  ViewController.swift
//  WebDataSyncDownolad
//
//  Created by Sinchon on 2021/04/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //다운로드 받을 URL을 생성
        let imageAddr = "https://i.pinimg.com/originals/b4/90/9f/b4909fff2c00d31c89a5d57a1f5cbf79.jpg"
        
        let imageUrl = URL(string: imageAddr)
        //동기적으로 다운로드 받기
        //Data 는 예외 처리를 반드시 해야 하는 함수라서 try! 으로 발생하지 않는다고 설정
        let imageData = try!  Data(contentsOf: imageUrl!)
        //다운로드 받은 데이터를 이미지로 변환
        let image = UIImage(data: imageData)
        //이미지 뷰에 출력
        imageView.image = image
        
        //문자열을 다운 받을 URL을 생성
        let textAddr = "http://tjoeun.co.kr/"
        let textURL = URL(string: textAddr)
        //문자열 다운로드
        let textData = try!Data(contentsOf: textURL!)
        //다운로드 받은 데이터를 문자열로 변환
        
        //UTF8로 변환
        //let text = String(data: textData, encoding: .utf8)
        
        //EUC-KR로 변환해서 생성
        let text = String(data: textData, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422)))
        NSLog("\(textData)")
        //텍스트 뷰에 출력
        textView.text = text
        
    }


}

