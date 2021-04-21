//
//  ViewController.swift
//  control
//
//  Created by Sinchon on 2021/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var button: UIButton!
    
    //키보드가 올라올 때 호출될 함수
    @objc func keyboardWillShow(notification:Notification) -> Void{
        let originalRect = button.frame
        button.frame = CGRect(x: originalRect.origin.x, y: originalRect.origin.y - 50, width: originalRect.width, height: originalRect.height)
    }
    
    @IBAction func click(_ sender: Any) {
        NSLog("버튼을 누름")
        
        label.text = tfEmail.text
        tfEmail.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //리소스로 추가한 이미지를 객체로 생성
        let image1 = UIImage(named:"btn_01.png")
        let image2 = UIImage(named:"btn_02.png")
        button.setBackgroundImage(image1, for: .normal)
        button.setBackgroundImage(image2, for: .highlighted)
        
        button.setTitle("보통", for: .normal)
        button.setTitle("누른 상태", for: .highlighted)
        
        //키보드 화면에 출력
        //tfEmail에서 이벤트가 발생하면 이벤트 처리 메소드를 self에서 찾음
        tfEmail.becomeFirstResponder()
        
        //delegate 설정
        tfEmail.delegate = self
        
        //노티피케이션과 함수 연결
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){
            (notification) -> Void in
            let originalRect = self.button.frame
            self.button.frame = CGRect(x: originalRect.origin.x, y: originalRect.origin.y - 50, width: originalRect.width, height: originalRect.height)
            
        
        }
    }

    @IBAction func returnPress(_ sender: Any) {
        tfEmail.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfEmail.resignFirstResponder()
    }
    
}


extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfEmail.resignFirstResponder()
        return true
    }
    
}
