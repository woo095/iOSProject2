//
//  FirstVC.swift
//  SwipeTab
//
//  Created by Sinchon on 2021/05/12.
//

import UIKit

class FirstVC: UIViewController {
    
    @objc func buttonTapped(){
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //버튼 생성
        let btn = UIButton()
        btn.addTaget(self, action:#selector(buttonTapped), for:.touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubView(btn)
        btn.setTitle("Button", for: .normal)
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
