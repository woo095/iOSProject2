//
//  ViewController.swift
//  UserDefineCell
//
//  Created by Sinchon on 2021/04/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    //출력할 데이터 배열
    var ar:Array<Dictionary<String, Any>> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //데이터 초기화
        ar.append(["name":"제시카","skill":"영어","imageName":"image1.png"])
        ar.append(["name":"유리","skill":"중국어","imageName":"image2.png"])
        ar.append(["name":"태연","skill":"댄스","imageName":"image3.png"])
        ar.append(["name":"윤아","skill":"댄스","imageName":"image4.png"])
        ar.append(["name":"티파니","skill":"영어","imageName":"image5.png"])
        ar.append(["name":"수영","skill":"일본어","imageName":"image6.png"])
        
        //테이블 뷰의 Delegate 와 DataSource 설정
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    //섹션의 개수를 설정하는 메소드 - 선택
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //섹션 별 행의 개수를 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 Identifier
        let cellIdentifier = "Girlsgeneration"
        //재사용 가능한 셀을 찾아오기 - 사용자 정의 셀로 형변환하기
     
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier) as! GirlsgenerationCell
        
        
        //필요한 데이터 출력
        //행번호에 해당하는 데이터를 찾아오기
        let dic = ar[indexPath.row]
        cell.lblName?.text = dic["name"] as! String
        cell.lblSkill?.text = dic["skill"] as! String
        cell.ImageView?.image = UIImage(named:dic["imageName"] as! String)
        
        
        return cell
    }
    
    //셀의 높이를 설정하는 메소드
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
