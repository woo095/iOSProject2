//
//  SecondViewController.swift
//  SwitchViewController
//
//  Created by Sinchon on 2021/04/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    var subData:String! = nil

    @IBOutlet weak var lblSecond: UILabel!
    @IBAction func moveMain(_ sender: Any) {
        let viewController = presentingViewController as! ViewController
        viewController.mainData = "전달하는 데이터"
        viewController.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
