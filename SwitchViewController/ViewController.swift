//
//  ViewController.swift
//  SwitchViewController
//
//  Created by Sinchon on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var mainData : String!{
        //값이 변경될 때 호출되는 함수
        didSet{
            viewIfLoaded?.setNeedsLayout()
        }
    }
    
    override func viewWillLayoutSubviews() {
        if mainData != nil{
            lblMain.text = mainData
        }
    }
    
    //뷰를 출력할 때 호출되는 메소드 재정의-

    @IBAction func push(_ sender: Any) {
        
        //네비게이션 컨트로럴를 이용해서 DetailViewController 출력
        let detail = self.storyboard?.instantiateViewController(identifier: "DetailViewController")
        
        //스토리보드에 디자인한 DetailViewController 출력
        self.navigationController?.pushViewController(detail!, animated: true)
    }
    @IBOutlet weak var lblMain: UILabel!
    @IBAction func moveSecond(_ sender: Any) {
        //이동할 뷰 컨트롤러 객체를 생성
        let secondViewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        //애니메이션 설정
        self.modalTransitionStyle = .flipHorizontal
        //화면 이동
        present(secondViewController, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "제목"
        
    }
    
    @IBAction func returned(segue:UIStoryboardSegue){
    lblMain.text = "세그웨이로 돌아왔습니다."
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //이동할 뷰 컨트롤러 찾아오기
        let destination = segue.destination as! SubViewController
        //destination 에서 프로퍼티를 호출해서 넘겨주면 됩니다.
    }
}

