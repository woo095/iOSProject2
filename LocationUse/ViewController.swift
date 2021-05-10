//
//  ViewController.swift
//  LocationUse
//
//  Created by Sinchon on 2021/05/10.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    
    
    @IBAction func updateLocation(_ sender: Any) {
        let btn = sender as! UIButton
        
        if btn.title(for: .normal) == "위치정보수집시작"{
            locationManager.startUpdatingLocation()
            btn.setTitle("위치정보수집중지", for: .normal)
            
            let center = CLLocationCoordinate2D(latitude: 37.5690886, longitude: 126.984652)
            
            let maxDistance = 1000.0
            
            region = CLCircularRegion(center: center, radius: maxDistance, identifier: "종로")
            
            locationManager.startMonitoring(for: region)
        } else {
            locationManager.stopUpdatingLocation()
            locationManager.stopMonitoring(for: region)
            btn.setTitle("위치정보수집시작", for: .normal)
        }
    }
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation:CLLocation!
    
    //영역에 대한 정보를 저장할 프로퍼티
    var region : CLCircularRegion!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //정밀도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //locationManager의 delegate 설정
        //locationManager만의 이벤트가 발생했을 때
        //호출될 메소드를 소유한 객체를 지정
        //안드로이드나 Java GUI의 Listener 지정
        locationManager.delegate = self
        
        //위치 정보 사용을 위한 메소드 호출
        //앱이 실행 중인 동안만 위치 정보를 사용
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //가장 마지막 위치 정보를 가져오기
        let latestLocation = locations[locations.count - 1]
        
        //위치 정보 가져오기
        let coordinate = latestLocation.coordinate
        
        //출력 - 위도, 경도, 고도
        lblLatitude.text = String(format: "%.4f", coordinate.latitude)
        lblLongitude.text = String(format: "%.4f", coordinate.longitude)
        lblAltitude.text = String(format: "%.4f", latestLocation.altitude)
        
        //시작위치 설정
        if startLocation == nil{
            startLocation = latestLocation
        }
        
        //이동한 거리 계산
        let distance = latestLocation.distance(from: startLocation)
        
        lblDistance.text = String(format: "%.2f", distance)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        let alert = UIAlertController(title: "위치 정보", message: "위치 정보 가져오기 실패", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        let alert = UIAlertController(title: "종로", message: "종로에 들어옴", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }

}
/*
extension ViewController : CLLocationManagerDelegate{
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            //가장 마지막 위치 정보를 가져오기
            let latestLocation = locations[locations.count - 1]
            
            //위치 정보 가져오기
            let coordinate = latestLocation.coordinate
            
            //출력 - 위도, 경도, 고도
            lblLatitude.text = String(format: "%.4f", coordinate.latitude)
            lblLongitude.text = String(format: "%.4f", coordinate.longitude)
            lblAltitude.text = String(format: "%.4f", latestLocation.altitude)
            
            //시작위치 설정
            if startLocation == nil{
                startLocation = latestLocation
            }
            
            //이동한 거리 계산
            let distance = latestLocation.distance(from: startLocation)
            
            lblDistance.text = String(format: "%.2f", distance)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
            let alert = UIAlertController(title: "위치 정보", message: "위치 정보 가져오기 실패", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
*/
