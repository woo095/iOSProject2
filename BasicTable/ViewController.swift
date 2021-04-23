//
//  ViewController.swift
//  BasicTable
//
//  Created by Sinchon on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //테이블 뷰에 출력할 문자열 배열
    //var girlsGnerations = [String]()
    
    //테이블 뷰에 출력할 이미지 이름 배열
    //var girlsImage = [String]()
    
    //테이블 뷰에 출력할 데이터를 소유한 배열
    var girlsGenerations = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        //문자열 배열에 데이터 추가
        girlsGnerations.append("제시카")
        girlsGnerations.append("윤아")
        girlsGnerations.append("유리")
        girlsGnerations.append("태연")
        girlsGnerations.append("티파니")
        girlsGnerations.append("수영")
        
        //이미지 파일 이름을 저장
        girlsImage.append("image1.jpg")
        girlsImage.append("image2.jpg")
        girlsImage.append("image3.jpg")
        girlsImage.append("image4.jpg")
        girlsImage.append("image5.jpg")
        girlsImage.append("image6.jpg")
        */
        
        let dict1 = ["name":"제시카","imageName":"image1.png", "skill":"영어"]
        let dict2 = ["name":"유리","imageName":"image2.png", "skill":"중국어"]
        let dict3 = ["name":"태연","imageName":"image3.png", "skill":"노래"]
        let dict4 = ["name":"윤아","imageName":"image4.png", "skill":"연기"]
        let dict5 = ["name":"티파니","imageName":"image5.png", "skill":"영어"]
        let dict6 = ["name":"수영","imageName":"image6.png", "skill":"일본어"]
        
        girlsGenerations.append(dict1)
        girlsGenerations.append(dict2)
        girlsGenerations.append(dict3)
        girlsGenerations.append(dict4)
        girlsGenerations.append(dict5)
        girlsGenerations.append(dict6)
        
        //타이틀을 설정
        self.title = "소녀시대"
        
        //테이블 뷰 사용을 위한 delegate와 dataSource 속성을 설정
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//테이블 뷰 관련 메소드
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    //행의 개수를 설정하는 메소드 - 필수
    //section 이 섹션(그룹) 번호
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girlsGenerations.count
    }
    
    //셀의 모양을 설정하는 메소드 - 필수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 identifier로 사용할 문자열
        let cellIdentifier = "Cell"
        //재사용 가능한 셀이 있으면 찾아오기
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        //재사용 가능한 셀이 없으면 생성
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        //행 번호에 해당되는 데이터를 찾아옵니다.
        let dict = girlsGenerations[indexPath.row]
        //셀의 세부 속성 설정
        //문자열 배열의 데이터를 레이블에 출력
        //indexPath 가 셀의 위치
        //indexPath.section 은 그룹 번호
        //indexPath.row 는 행 번호
        //cell?.textLabel?.text = girlsGnerations[indexPath.row]
        cell?.textLabel?.text = dict["name"] as! String
        
        //이미지 출력
        //cell?.imageView?.image = UIImage(named: girlsImage[indexPath.row % girlsImage.count])
        cell?.imageView?.image = UIImage(named:dict["imageName"] as! String)
        //보조 텍스트 출력
        cell?.detailTextLabel?.text = dict["skill"] as? String
        
        //액세서리 출력
        cell?.accessoryType = .disclosureIndicator
        
        //보조 텍스트 출력
        /*if indexPath.row < 3{
            cell?.detailTextLabel?.text = "앞의 3명"
        }else {
            cell?.detailTextLabel?.text = "뒤의 3명"
        }*/
        
        //액세서리 출력
        //cell?.accessoryType = .disclosureIndicator
        
        if indexPath.row % 2 == 0{
            cell?.backgroundColor = UIColor.red
        } else {
            cell?.backgroundColor = UIColor.blue
        }
        
        return cell!
    }
    
    //행의 높이를 설정하는 메소드
    func tableView(_ tableView: UITableView, heightForRowAt section: Int) -> CGFloat {
        return 80
    }
    
    //행의 들여쓰기를 설정하는 메소드
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.row % 2 == 0 {
            return 2
        }else {
            return 1
        }
    }
    
    //셀을 선택했을 때 호출되는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "선택한 이름", message: girlsGenerations[indexPath.row]["name"] as? String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        present(alert, animated: true)
    }
}
