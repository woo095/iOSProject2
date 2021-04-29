//
//  ViewController.swift
//  AsyncDownload
//
//  Created by Sinchon on 2021/04/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //스레드 객체 생성
        let thread = Downloader()
        thread.imageView = imageView
        thread.textView = textView
        //스레드를 시작
        thread.start()
    }


}

