//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Sinchon on 2021/04/29.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*let request = AF.request("https://httpbin.org/get", method:.get, parameters:nil)
        request.response{
            response in let msg = String(data: response.data!, encoding: .utf8)
            NSLog(msg!)
        }*/
        
        /*
        let request = AF.request("https://www.daum.net", parameters: nil)
        request.responseString(completionHandler: {
            response -> Void in NSLog(response.value!)
        })
 */
        /*
        let request = AF.request("https://upload.wikimedia.org/wikipedia/commons/0/0f/%EC%84%A0%EB%8F%99%EC%97%B4_%28KIA_%ED%83%80%EC%9D%B4%EA%B1%B0%EC%A6%88_%EA%B0%90%EB%8F%85%29.jpg",method: .get, parameters: nil)
        request.response{
            response in
            //다운로드 받은 데이터를 가지고 UIImage 객체 생성
            let image = UIImage(data: response.data!)
            //이미지 객체를 가지고 이미지 뷰를 생성해서 현재 뷰에 배치
            let imageView = UIImageView(image: image)
            self.view.addSubview(imageView)
        }
        
        */
        
        /*
        //다운로드 받을 URL 생성
        let addr = "https://dapi.kakao.com/v3/search/book?target=title&query="
        let query = "자바".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "\(addr)\(query)"
        
        //헤더를 추가한 요청 객체 만들기
        let request = AF.request(url, method:.get, encoding: JSONEncoding.default,headers: ["Authorization" : "KakaoAK 147d0ed7244ce07161111c406d030b01"])
        
        //json 요청
        request.responseJSON{
            response in
            //print(response.value!)
            
            //다운로드 받은 데이터를 딕셔너리로 변환
            if let result = response.value as? [String:Any]{
                let documents = result["documents"] as! NSArray
                for index in 0...(documents.count - 1){
                    //데이터 하나 가져오기
                    let item = documents[index] as! NSDictionary
                    
                    var title = item["title"]!
                    var price = item["price"]!
                    
                    NSLog("\(title)\(price)")
                }
            }
            
        }
         */
        
        /*
        
        //업로드할 데이터 생성
        let image = UIImage(named: "jobs.jpeg")
        let imageData = image?.jpegData(compressionQuality: 0.5)
        
        AF.upload(multipartFormData: {
            multipartFormData in
            multipartFormData.append(Data("잡스".utf8), withName:"itemname")
            multipartFormData.append(Data("9995".utf8), withName:"price")
            multipartFormData.append(Data("CEO".utf8), withName:"description")
            multipartFormData.append(Data("2021-04-29".utf8), withName:"updatedate")
            multipartFormData.append(imageData!, withName:"pictureurl", fileName:"jobs.jpg", mimeType: "image/jpg")
        }, to: "http://cyberadam.cafe24.com/item/insert").responseJSON{
            response in
            if let jsonResult = response.value as? [String:Any]{
                let result = jsonResult["result"] as! Int
                NSLog("결과:\(result)")
            }
        }
         */
        
        //파라미터 만들기
        let parameters = ["itemid":"21"]
        let request = AF.request("http://cyberadam.cafe24.com/item/delete", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
        request.responseJSON{
            response in
            if let jsonResult = response.value as? [String:Any]{
                let result = jsonResult["result"] as! Int
                let alert = UIAlertController(title: "삭제 여부", message: "\(result)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert,animated: true)
            }
        }
    }


}

