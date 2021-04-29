//
//  Downloader.swift
//  AsyncDownload
//
//  Created by Sinchon on 2021/04/29.
//

import UIKit

class Downloader : Thread {
    
    //출력을 위한 뷰 프로퍼티
    var imageView : UIImageView!
    var textView : UITextView!
    
    //스레드로 동작할 메소드
    override func main(){
        OperationQueue().addOperation {
            
        let textURL = URL(string: "https://www.google.com")
        let textData = try! Data(contentsOf: textURL!)
        let googleText = String(data: textData, encoding: .utf8)
        
        self.textView.text = googleText
        
        let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/640px-Flag_of_South_Korea.svg.png")
        let imageData = try! Data(contentsOf: imageURL!)
        let image = UIImage(data: imageData)
            
        self.imageView.image = image!
            
        }
    }
}
