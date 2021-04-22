//
//  ViewController.swift
//  notification
//
//  Created by Sinchon on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func login(_ sender: Any) {
        //대화상 자 생성
        let alert = UIAlertController(title: nil, message: "로그인", preferredStyle: .alert)
        
        //텍스트 필드를 추가
        alert.addTextField(configurationHandler: {(tf) -> Void in tf.placeholder="아이디를 입력하세요!!!"
            tf.isSecureTextEntry = false
        })
        
        alert.addTextField(configurationHandler: {(tf) -> Void in tf.placeholder="비밀번호를 입력하세요!!!"
            tf.isSecureTextEntry = false
        })
        
        //버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "로그인", style: .default, handler: {(_) -> Void in
            //첫번째 텍스트 필드에 입력한 내용 가져오기
            let id = alert.textFields?[0].text
            //두번째 텍스트 필드에 입력한 내용 가져오기
            let pw = alert.textFields?[1].text
            
            if id == "adam" && pw == "1234"{
                NSLog("로그인 성공")
            } else {
                NSLog("로그인 실패")
            }
        }))
        
        //대화상자 출력
        present(alert, animated: true)
    }
    @IBAction func showAlert(_ sender: Any) {
        //대화사자 출력
        let alert = UIAlertController(title: "대화상자", message: "마음대로 작성합니다.", preferredStyle: .alert)
        
        //버튼 추가
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(UIAlertAction(title: "확인", style: .default){
            (_) in NSLog("확인을 누르셨습니다.")
        })
        
        //대화상자 출력
        present(alert, animated: true)
        
        //이 코드는 대화상자가 출력되자 마자 수행됩니다.
        NSLog("대화상자가 없어지기 전에 수행")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

