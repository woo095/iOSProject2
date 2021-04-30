//
//  InputViewController.swift
//  LocalSave
//
//  Created by Sinchon on 2021/04/30.
//

import UIKit

class InputViewController: UIViewController {
    @IBOutlet weak var tfUserDefaults: UITextField!
    @IBOutlet weak var tfAppDelegate: UITextField!
    @IBAction func btnSave(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = tfUserDefaults.text
        let email = tfAppDelegate.text
        // Do any additional setup after loading the view.
        
        //AppDelegate wjwkd
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.name = name!
        
        
        //환경 설정에 저장
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "email")
        
        //자신을 출력한 뷰 컨트롤러를 이용
        let viewController = presentingViewController as! ViewController
        viewController.dismiss(animated: true){
            () -> Void in
            //출력하는 함수 호출
            viewController.display()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
