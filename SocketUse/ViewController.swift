//
//  ViewController.swift
//  SocketUse
//
//  Created by Sinchon on 2021/04/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfMsg: UITextField!
    @IBOutlet weak var tvMsg: UITextView!
    
    //통신할 서버의 IP와 포트 번호
    let host = "192.168.35.33"
    let port = 9999
    
    //통신할 클라이언트 프로퍼티
    var client : TCPClient!
    
    //문자열을 대입받아 텍스트뷰에 추가하는 메소드
    func appendToTextView(string:String){
        tvMsg.text = tvMsg.text.appending("\n\(string)")
    }
    
    //서버로부터 받은 데이터를 문자열로 만들어 리턴하는 메소드
    func readResponse(from client:TCPClient) -> String?{
        sleep(3)
        
        //받은 데이터를 response에 저장하고 받은게 없다면 nil을 리턴
        
        guard let response = client.read(1024 * 10)
        else{
            return nil
        }
        
        //받은 데이터가 있으면 문자열로 변환해서 리턴
        return String(bytes: response, encoding: .utf8)
    }
    
    func sendRequest(string:String, using client:TCPClient) -> String?{
        appendToTextView(string: "데이터 전송 중...")
        
        switch  client.send(string:string) {
        case .success:
            return readResponse(from: client)
        case .failure(let error):
            appendToTextView(string: String(describing: error))
            return nil
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        //클라이언트 가져오기
        guard let client = client else{
            return
        }
        
        //연결
        switch client.connect(timeout: 30){
        //성공하면 입력한 메시지 전송
        case .success:
            appendToTextView(string: "서버 연결 성공")
            if let response = sendRequest(string: "\(tfMsg.text)\n\n", using: client){
                appendToTextView(string: "응답:\(response)")
            }
        //연결에 실패하면 실패 메시지 출력
        case .failure(let error):
            appendToTextView(string: String(describing: error))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //client 초기화
        client = TCPClient(address: host, port: Int32(port))
        // Do any additional setup after loading the view.
        
        //네트워크 사용 여부 확인
        let reachability = Reachability()
        let result = reachability.isConnectedToNetwork()
        
        var msg = ""
        if result == true {
            msg = "네트워크 사용 가능"
        }else {
            msg = "네트워크 사용 불가능"
        }
        
        //대화상자로 출력하기
        let alert = UIAlertController(title: "네트워크 사용 여부", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
        
        NSLog("네트워크 사용 여부:\(msg)")
    }


}

