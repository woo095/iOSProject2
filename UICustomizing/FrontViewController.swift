//
//  FrontViewController.swift
//  UICustomizing
//
//  Created by Sinchon on 2021/05/12.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let revealVC = self.revealViewController() {
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(animated:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
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
