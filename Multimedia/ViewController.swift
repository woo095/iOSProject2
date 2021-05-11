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
        //업로드 할 URL: http://192.168.1.143/item/insert
        //전송 방식: post
        //파일 업로드 여부: 있음
        //파라미터: itemname, description, price, pictureurl
        //헤더: 없음
        
        //결과는 어떤 형식: json
        //결과 해석: {result:true 또는 false}
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
