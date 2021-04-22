//
//  ViewController.swift
//  gesture
//
//  Created by Sinchon on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView:UIImageView!
    
    //탭 제스쳐가 사용할 selector
    @objc func tapGestureMethod(sender:UITapGestureRecognizer){
        if self.imgView.contentMode == UIView.ContentMode.scaleAspectFit{
            self.imgView.contentMode = UIView.ContentMode.center
        } else {
            self.imgView.contentMode = UIView.ContentMode.scaleAspectFit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod(sender:)))
        
        tap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(tap)
    }


}

