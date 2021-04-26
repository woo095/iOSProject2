//
//  PlayerTableViewController.swift
//  GroupTableDisplay
//
//  Created by Sinchon on 2021/04/26.
//

import UIKit

class PlayerTableViewController: UITableViewController {
    //기본 데이터를 저장할 프로퍼티
    var data:Array<String> = []
    
    //섹션 별로 분류한 데이터를 저장할 프로퍼티 - 딕셔너리
    var sectionData:Array<Dictionary<String, Any>> = []
    
    //분류할 때 사용할 인덱스를 저장할 프로퍼티 - 문자열
    var indexes:Array<String> = []
    
    //문자열을 매개변수로 받아서 첫번째 글자의 자음을 리턴하는 메소드
    func subtract(data:String) -> String{
        var result = data.compare("나")
        if result == ComparisonResult.orderedAscending{
            return "ㄱ"
        }
        result = data.compare("다")
        if result == ComparisonResult.orderedAscending{
            return "ㄴ"
        }
        result = data.compare("라")
        if result == ComparisonResult.orderedAscending{
            return "ㄷ"
        }
        result = data.compare("마")
        if result == ComparisonResult.orderedAscending{
            return "ㄹ"
        }
        result = data.compare("바")
        if result == ComparisonResult.orderedAscending{
            return "ㅁ"
        }
        result = data.compare("사")
        if result == ComparisonResult.orderedAscending{
            return "ㅂ"
        }
        result = data.compare("아")
        if result == ComparisonResult.orderedAscending{
            return "ㅅ"
        }
        result = data.compare("자")
        if result == ComparisonResult.orderedAscending{
            return "ㅇ"
        }
        result = data.compare("차")
        if result == ComparisonResult.orderedAscending{
            return "ㅈ"
        }
        result = data.compare("카")
        if result == ComparisonResult.orderedAscending{
            return "ㅊ"
        }
        result = data.compare("타")
        if result == ComparisonResult.orderedAscending{
            return "ㅋ"
        }
        result = data.compare("파")
        if result == ComparisonResult.orderedAscending{
            return "ㅌ"
        }
        result = data.compare("하")
        if result == ComparisonResult.orderedAscending{
            return "ㅍ"
        }
        return "ㅎ"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append("김선빈")
        data.append("최형우")
        data.append("브룩스")
        data.append("멩덴")
        data.append("이의리")
        data.append("차유라")
        data.append("이승만")
        data.append("김성모")
        data.append("나진철")
        
        //인덱스 생성
        indexes.append("ㄱ")
        indexes.append("ㄴ")
        indexes.append("ㄷ")
        indexes.append("ㄹ")
        indexes.append("ㅁ")
        indexes.append("ㅂ")
        indexes.append("ㅅ")
        indexes.append("ㅇ")
        indexes.append("ㅈ")
        indexes.append("ㅊ")
        indexes.append("ㅋ")
        indexes.append("ㅌ")
        indexes.append("ㅍ")
        indexes.append("ㅎ")
        
        var temp : [[String]] = Array(repeating: Array(), count: 14)
        
        var i=0
        while i < indexes.count{
            let firstNames = indexes[i]
            //data 순회
            var j = 0
            while j<data.count{
                let str = data[j]
                if firstNames == subtract(data: str){
                    temp[i].append(str)
                }
                j = j + 1
            }
            i = i + 1
        }
        
        //분류된 데이터를 내부적으로 정렬
        i = 0
        while i < temp.count{
            if temp[i].count >= 2{
                temp[i].sort()
            }
            
            i = i + 1
        }
        
        //데이터가 존재하는 것만 첫번째 글자와 배열을 딕셔너리로 묶어서 sectionData에 추가
        
        i = 0
        while i < indexes.count{
            //배열에 데이터가 있는 경우만
            if temp[i].count > 0 {
                var dic : Dictionary<String, Any> = ["section_name":indexes[i],"data":temp[i]]
                sectionData.append(dic)
            }
            
            i = i + 1
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //섹션의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //세션번호를 딕셔너러리를 찾아옵니다.
        let dic = sectionData[section]
        //딕셔너리에서 section_name 의 값을 가져옵니다.
        //Array는 직접 변환이 안되지만 String은 직접 변환 가능
        let str = (dic["section_name"] as! NSString) as String
        
        return str
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //섹션 번호에 해당하는 데이터를 찾아옵니다.
        let dic = sectionData[section]
        //데이터를 찾아와 개수를 가져옵니다.
        let players = (dic["data"] as! NSArray) as Array
        return players.count
    }

    
    //셀의 모양을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }

        // Configure the cell...
        
        //섹션 번호를 이용해서 딕셔너리를 찾고 다시 딕셔너리에서 배열을 찾고 배열에서 행번호를 가지고 데이터를 찾아옵니다.
        
        let dic = sectionData[indexPath.section]
        
        let players = (dic["data"] as! NSArray) as Array
        
        let player = players[indexPath.row] as! String
        
        //데이터 출력
        cell?.textLabel?.text = player

        return cell!
    }
    

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
