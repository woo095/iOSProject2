//
//  ViewController.swift
//  iOSProject2
//
//  Created by Sinchon on 2021/04/21.
//

import UIKit

class ViewController: UIViewController{
    //뷰 컨트롤러가 FirstResponder가 될 수 있도록 해주는 프로퍼티
    
    @IBOutlet weak var Label: UILabel!
    
    var timer:Timer? = nil
    
    override var canBecomeFirstResponder: Bool{
        get {
            return true
        }
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) -> Void in
            //현재 날짜 및 시간
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
            let msg = formatter.string(from: date)
            self.Label.text = msg
        })
        
        //회전
        Label.transform=CGAffineTransform(rotationAngle:CGFloat.pi/2.0)
    }
    

    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        NSLog("흔들기 시작")
    }
}

