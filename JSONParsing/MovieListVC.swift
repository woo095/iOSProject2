//
//  MovieListVC.swift
//  JSONParsing
//
//  Created by Sinchon on 2021/04/29.
//

import UIKit

class MovieListVC: UITableViewController {
    var movies : Array<Dictionary<String, String>> =  []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "영화 목록"
        
        //데이터 다운로드
        let url = URL(string: "http://cyberadam.cafe24.com/movie/list")
        let data = try! Data(contentsOf: url!)
        
        //문자열로 변환
        let jsonString = String(data: data, encoding: .utf8)
        //NSLog(jsonString!)
        
        //문자열을 딕셔너리로 변환
        let movieResult = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        //list 키의 데이터를 배열로 변환
        let movieList = movieResult["list"] as! NSArray
        
        //배열의 데이터 순회
        for index in 0...(movieResult.count - 1){
            let movie = movieList[index] as! NSDictionary
            
            let title = movie["title"] as! String
            let image = movie["thumbnail"] as! String
            
            let dict = ["title": title, "image": image]
            
            movies.append(dict)
        }
        
        NSLog("\(movies)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }

        // Configure the cell...
        
        //행번호에 해당하는 데이터 가져오기
        let movie = movies[indexPath.row]
        
        cell?.textLabel?.text = movie["title"]
        
        let addr = movie["image"]!
        
        let imageUrl = "http://cyberadam.cafe24.com/movieimage/\(addr)"
        
        let url = URL(string: imageUrl)
        let imageData = try! Data(contentsOf: url!)
        let image = UIImage(data: imageData)
        cell?.imageView?.image = image

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
