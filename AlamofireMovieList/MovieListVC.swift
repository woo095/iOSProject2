//
//  MovieListVC.swift
//  AlamofireMovieList
//
//  Created by Sinchon on 2021/04/30.
//

import UIKit

import Alamofire

class MovieListVC: UITableViewController {
    //현재 출력한 페이지 번호를 저장할 프로퍼티
    var page = 0
    //마지막 셀이 처음 보여진 것인지 여부를 설정하는 프로퍼티
    var flag = false
    
    //파싱한 결과를 저장할 프로퍼티
    var movieList : Array<MovieVo> = []
    
    //데이터를 파싱해서 저장하고 테이블 뷰를 다시 출력하는 사용자 정의 함수
    func downloadData(){
        page = page + 1
        //다운 받을 URL을 생성합니다.
        let addr = "http://cyberadam.cafe24.com/movie/list?page=\(page+1)"
        
        
        //위의 URL에 get 방식으로 요청할 객체 생성
        let request = AF.request(addr, method:.get, encoding: JSONEncoding.default, headers:[:])
        
        //JSON 결과를 가져와 사용하기
        request.responseJSON{
            response in
            
            //swift - JSONObject - NSDictionary - [String:Any]
            //JSONArray - NSArray - [Any]
            
            if let jsonResult = response.value as?
                [String:Any]{
                let list = jsonResult["list"] as! NSArray
                for index in 0...(list.count-1){
                    let item = list[index] as! NSDictionary
                    var movie = MovieVo()
                    movie.title = item["title"] as? String
                    movie.genre = item["genre"] as? String
                    movie.link = item["link"] as? String
                    movie.thumbnail = item["thumbnail"] as? String
                    
                    //실수로 변환해서 저장
                    //movie.rating = ((item["rating"] as! NSNumber).doubleValue))
                    movie.rating = ((item["rating"] as? NSNumber)?.doubleValue)
                    
                    let url = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail)")
                    
                    //thumbnail 값을 이용해 이미지를 다운받아 movie.image에 대입
                    let imageData = try! Data(contentsOf: url!)
                    movie.image = UIImage(data: imageData)
                    
                    //배열에 데이터를 저장
                    self.movieList.append(movie)
                }
                
                //테이블 뷰를 다시 출력
                self.tableView.reloadData()
                
                NSLog("\(self.movieList)")
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "영화 목록"
        downloadData()
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
        return movieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //사용자 정의 셀 객체 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        // Configure the cell...
        
        let movie = movieList[indexPath.row]
        
        cell.lblTitle.text = movie.title!
        cell.lblGenre.text = movie.genre!
        cell.lblRating.text = "\(movie.rating!)"
        cell.imgThumbnail.image = movie.image!
        

        return cell
    }
    
    //행의 높이를 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //테이블 뷰에서 스크롤 하면 호출되는 메소드
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //처음 마지막 셀이 출력되면
        if flag == false && indexPath.row == self.movieList.count - 1{
            flag = true
        }
        
        else if flag == true && indexPath.row == self.movieList.count - 1{
            downloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let movieLinkVC = storyboard?.instantiateViewController(identifier: "MovieLinkVC") as! MovieLinkVC
        
        //행 번호에 해당하는 데이터 찾아오기
        let movie = movieList[indexPath.row]
        //하위 데이터 넘겨주니
        movieLinkVC.link = movie.link
        //하위 뷰 컨트롤러 출력
        navigationController?.pushViewController(movieLinkVC, animated: true)
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
