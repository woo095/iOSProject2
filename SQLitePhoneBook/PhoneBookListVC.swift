//
//  PhoneBookListVC.swift
//  SQLitePhoneBook
//
//  Created by Sinchon on 2021/05/03.
//

import UIKit

class PhoneBookListVC: UITableViewController {
    
    var phoneBook:[(num:Int, name:String, phone:String, addr:String)]!
    
    let dao = PhoneBookDAO()
    
    @IBAction func add(_ sender: Any){
        let alert = UIAlertController(title: "신규 등록", message: "등록할 연락처를 입력하세요!", preferredStyle: .alert)
        
        //입력란 만들기
        alert.addTextField(){(tf) in tf.placeholder = "이름"}
        alert.addTextField(){(tf) in tf.placeholder = "전화번호"}
        alert.addTextField(){(tf) in tf.placeholder = "주소"}
        
        //버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default){(_) in
            //입력한 내용 가져오기
            let name = alert.textFields?[0].text
            let phone = alert.textFields?[1].text
            let addr = alert.textFields?[2].text
            
            //데이터 삽입
            if self.dao.create(name: name, phone: phone, addr: addr){
                //데이터 다시 가져오기
                self.phoneBook = self.dao.find()
                //테이블 뷰 다시 출력
                self.tableView.reloadData()
                
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "연락처\n총 \(self.phoneBook.count)개"
            }
        })
        
        //대화상자 출력
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //전체 데이터 불러오기
        phoneBook = self.dao.find()
        //UI 초기화
        
        //네비게이션 바의 중앙에 출력할 타이틀 뷰 생성
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "연락\n \(self.phoneBook.count) 명"
        self.navigationItem.titleView = navTitle
        
        //네비게이션 바의 왼쪽에 편집 버튼 추가
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.allowsSelectionDuringEditing = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return phoneBook.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PHONE_CELL"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        //행번호에 해당하는 데이터를 가져오기
        let record = phoneBook[indexPath.row]
        
        //데이터 출력
        cell?.textLabel?.text = record.name
        cell?.detailTextLabel?.text = "\(record.phone) \(record.addr)"

        // Configure the cell...

        return cell!
    }
    
    //edit 버튼을 누를 때 아이콘을 설정하는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let num = self.phoneBook[indexPath.row].num
        
        if self.dao.delete(num: num){
            self.phoneBook.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
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
