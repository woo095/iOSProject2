//
//  ViewController.swift
//  Multimedia
//
//  Created by Sinchon on 2021/05/11.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire


class ViewController: UIViewController {
    //오디오 재생기
    var audioPlayer : AVAudioPlayer?

    @IBAction func audioPlay(_ sender: Any) {
        //오디오를 백그라운드에서도 재생할 수 있도록 옵션 추가
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback, mode: .default, policy: .longFormAudio, options: [])
        }catch let error{
            NSLog(error.localizedDescription)
        }
        if let player = audioPlayer{
            player.play()
        }
        
        
    }
    @IBAction func audioStop(_ sender: Any) {
        if let player = audioPlayer{
            player.stop()
        }
    }
    @IBAction func changeVolume(_ sender: Any) {
        if let player = audioPlayer{
            let slider = sender as! UISlider
            player.volume = slider.value
        }
    }
    //코드로 재생 버튼을 눌렀을때 호출되는 메소드
    @IBAction func videoPlay(_ sender: Any) {
        //동영상 파일의 경로 생성
        let filePath = Bundle.main.path(forResource: "IPhone3G", ofType: "mov")
        let url = URL(fileURLWithPath: filePath!)
        
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        
        player.play()
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 컨트롤러를 생성하고 옵션을 설정
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // 이미지 편집 가능
        
        //UIImagePickerController에서 이벤트가 발생하면 호출할 메소드이 위치를 설정
        picker.delegate = self
        
        //출력
        present(picker, animated: true)
    }
    @IBAction func upload(_ sender: Any) {
        //업로드 할 URL: http://192.168.1.149/item/insert
        //전송 방식: post
        //파일 업로드 여부: 있음
        //파라미터: itemname, description, price, pictureurl
        //헤더: 없음
        
        //결과는 어떤 형식: json
        //결과 해석: {result:true 또는 false}
        
        //3개의 문자열을 입력받는 대화상자
        let addAlert = UIAlertController(title: "데이터 추가", message: "추가할 데이터를 입력하세요!!", preferredStyle: .alert)
        
        //텍스트 필드 추가
        addAlert.addTextField(){
            (tf) -> Void in
            //텍스트 필드의 옵션을 설정
            tf.placeholder = "이름을 입력하세요!!"
        }
        
        addAlert.addTextField(){
            (tf) -> Void in
            //텍스트 필드의 옵션을 설정
            tf.placeholder = "가격을 입력하세요!!"
            //키패드 설정
            tf.keyboardType = .numberPad
        }
        
        addAlert.addTextField(){
            (tf) -> Void in
            //텍스트 필드의 옵션을 설정
            tf.placeholder = "설명을 입력하세요!!"
        }
        
        //단순하게 대화상자를 닫는 버튼
        addAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        //버튼을 눌렀을 때 작업을 수행
        addAlert.addAction(UIAlertAction(title: "추가", style: .default){
            (action) -> Void in
            
            //입력 받은 내용 가져오기
            let itemname = addAlert.textFields?[0].text
            let price = addAlert.textFields?[1].text
            let description = addAlert.textFields?[2].text
            
            let parameters = ["itemname":itemname!, "price":price!, "description":description!]
            
            AF.upload(multipartFormData: {multipartFormData -> Void in
                //파라미터를 전송
                for (key, value) in parameters{
                    multipartFormData.append((value as String).data(using: .utf8)!, withName: key)
                }
                let image = self.imageView.image
                if image != nil{
                    multipartFormData.append(image!.pngData()!, withName: "pictureurl", fileName: "file.png", mimeType: "image/png")
                }
            }, to: "http://192.168.1.149/item/insert", method: .post, headers: nil).responseJSON{
                response in
                //결과가 전송된 경우 수행할 내용
                if let jsonObject = response.value as? [String:Any]{
                    let result = jsonObject["result"] as? Bool
                    var msg = ""
                    if result!{
                        msg = "삽입 성공"
                    }else {
                        msg = "삽입 실패"
                    }
                    
                    let msgAlert = UIAlertController(title: "데이터", message: msg, preferredStyle: .alert)
                    
                    msgAlert.addAction(UIAlertAction(title: "확인", style: .default))
                    
                    self.present(msgAlert, animated: true)
                }
            }
        })
        
        self.present(addAlert, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //초기화 작업
        //노래 파일의 경로 생성
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp3")!, relativeTo: nil)
        
        //let url = URL(string:"http://yberadam.cafe24.com/song/if.mp3")
        
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        
        
        /*
        //내장 사운드를 도큐먼트 디렉토리로 복사해서 재생
        //내장 사운드 파일의 경로를 생성
        let path = "System/Library/Audio/UISounds/SIMToolkitGeneralBeep.caf"
        
        //복사할 파일 경로 생성
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let file = docsDir + "/test.caf"
        
        //파일 복사
        try! FileManager.default.copyItem(atPath: path, toPath: file)
        
        let url = URL(fileURLWithPath: file, relativeTo: nil)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        */
 
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //목적지를 가져옵니다.
        let destination = segue.destination as! AVPlayerViewController
        
        //비디오 파일의 URL 생성
        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        
        //재생
        destination.player = AVPlayer(url: url!)
    }

}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //이미지를 선택하지 않고 취소 버튼을 눌렀을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false){
            () in
            let alert = UIAlertController(title: "이미지 피커", message: "이미지를 선택하지 않음", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    //이미지를 선택하고 확인 버튼을 눌렀을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false){() in
            //선택한 이미지를 이미지 뷰에 출력
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imageView.image = img
        }
    }
}
