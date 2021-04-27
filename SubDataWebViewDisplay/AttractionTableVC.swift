//
//  AttractionTableVC.swift
//  SubDataWebViewDisplay
//
//  Created by Sinchon on 2021/04/27.
//

import UIKit

class AttractionTableVC: UITableViewController {
    
    //테이블 뷰에 출력할 배열 생성
    var attractionData : Array<Dictionary<String, String>> = []
    
    //RefreshControl이 보여지면 호출되는 메소드
    @objc func handleRefresh(_ refreshControl:UIRefreshControl){
        //데이터 추가
        let dic1 = ["name":"그랜드캐년","image":"grand_canyon.jpg", "url":"https://en.wikipedia.org/wiki/Grand_Canyon_National_Park"]
        let dic2 = ["name":"윈저궁","image":"windsor_castle.jpg", "url":"https://en.wikipedia.org/wiki/Windsor_Castle"]
        
        //맨 앞에 추가
        attractionData.insert(dic1, at: 0)
        attractionData.insert(dic2, at: 0)
        
        //RefreshControl 제거
        refreshControl.endRefreshing()
        
        //애니메이션과 함께 데이터를 재출력
        tableView.beginUpdates()
        
        tableView.insertRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .top)
        
        tableView.endUpdates()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let dic1 = ["name":"버킹험 궁전", "image":"buckingham_palace.jpg", "url":"http://en.wikipedia.org/wiki/Buckingham_Palce"]
        let dic2 = ["name":"에펠탑", "image":"eiffel_tower.jpg", "url":"http://en.wikipedia.org/wiki/Eiffel_Tower"]
        let dic3 = ["name":"엠파이어 빌딩", "image":"empire_state_building.jpg", "url":"http://en.wikipedia.org/wiki/Empire_State_Building"]
        
        
        attractionData.append(dic1)
        attractionData.append(dic2)
        attractionData.append(dic3)
        
        self.title = "살면서 가볼만한 곳"
        
        //RefreshControl을 생성해서 부착
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        
        //버전 확인
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return attractionData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionTableCell", for: indexPath) as! AttractionTableCell
        
        let dic = attractionData[indexPath.row]
        //레이블에 name 출력
        cell.attractionLabel.text = dic["name"]
        cell.attractionImage.image = UIImage(named: dic["image"]!)
        
        return cell
    }
    
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택한 행 번호에 해당하는 데이터 가져오기
        let dic = attractionData[indexPath.row]
        //url 키의 값 가져오기
        let url = dic["url"]
        
        //출력할 하위 뷰 컨트롤러 객체 생성
        let detailVC = storyboard?.instantiateViewController(identifier: "AttractionDetailVC") as! AttractionDetailVC
        
        detailVC.webAddress = url
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //마지막에서 스크롤 했는지 여부를 저장할 프로퍼티
    var flag = false
    
    //셀 들이 보여질 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if flag == false && indexPath.row == attractionData.count - 1{
            flag = true
        } else if(flag == true && indexPath.row == attractionData.count - 1){
            
            //데이터 추가 - 맨 앞에 추가
            let dic1 = ["name":"그랜드캐년","image":"grand_canyon.jpg", "url":"https://en.wikipedia.org/wiki/Grand_Canyon_National_Park"]
            let dic2 = ["name":"윈저궁","image":"windsor_castle.jpg", "url":"https://en.wikipedia.org/wiki/Windsor_Castle"]
            
            attractionData.append(dic1)
            attractionData.append(dic2)
            
            tableView.reloadData()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
