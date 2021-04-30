//
//  ViewController.swift
//  LocalSave
//
//  Created by Sinchon on 2021/04/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblAppDelegate: UILabel!
    @IBOutlet weak var lblUserDefaults: UILabel!
    @IBAction func btnAdd(_ sender: Any) {
        //네비게이션 컨트롤러를 이용하지 않고 하위 뷰 컨트롤러를 생성해 출력
        let inputViewController = storyboard?.instantiateViewController(identifier: "InputViewController") as! InputViewController
        //출력
        present(inputViewController, animated: true)
    }
    
    //데이터 출력을 위한 함수
    func display(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        lblAppDelegate.text = appDelegate.name
        
        
        //UserDefaults 의 email 프로퍼티의 값을 lblUserDefaults 에 출력
        
        if let email = (UserDefaults.standard).string(forKey: "email"){
            lblUserDefaults.text = email
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        display()
    }

    @IBAction func btnfileSave(_ sender: Any) {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        
        let dataFile = docsDir + "/data.txt"
        
        let dataBuffer = "안녕하세요 스위프트".data(using: .utf8)
        
        FileManager.default.createFile(atPath: dataFile, contents: dataBuffer, attributes: nil)
    }
    @IBAction func btnfileRead(_ sender: Any) {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0]
        
        let dataFile = docsDir + "/data.txt"
        
        let dataBuffer = FileManager.default.contents(atPath: dataFile)
        
        let msg = String(data: dataBuffer!, encoding: .utf8)
        
        lblAppDelegate.text = msg
    }
    
}

