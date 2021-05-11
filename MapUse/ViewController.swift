//
//  ViewController.swift
//  MapUse
//
//  Created by Sinchon on 2021/05/10.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    //위치 정보 사용을 위한 객체
    var locationManager:CLLocationManager?
    
    //특정 영역에 접근하면 이미지를 출력하기 위한 프로퍼티
    var region : CLCircularRegion!
    var couponView:UIImageView!
    
    
    @IBAction func type(_ sender: Any) {
        if mapView.mapType == MKMapType.standard{
            mapView.mapType = .satellite
        } else {
            mapView.mapType = .standard
        }
    }
    var m : CLLocationDistance = 3000
    @IBAction func zoom(_ sender: Any) {
        //현재 위치 가져오기
        let userLocation = mapView.userLocation
        
        //지도의 출력 크기 설정 - 현재 위치를 기준으로 반경 3km
        let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: m, longitudinalMeters: 3000)
        m = m / 2
        mapView.setRegion(region, animated: true)
    }
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.title = "위치 정보 사용"
        //위치 정보 사용을 위한 객체 생성
        locationManager = CLLocationManager()
        //위치 정보를 언제 사용할 지 설정
        locationManager?.requestWhenInUseAuthorization()
        //맵 뷰가 현재 위치를 사용할 수 있도록 설정
        mapView.showsUserLocation = true
        
        //mapView의 delegate 설정
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.5690886, longitude: 126.984652)
        let maxDistance = 1000.0
        region = CLCircularRegion(center: center, radius: maxDistance, identifier: "종로")
        
        locationManager?.startMonitoring(for: region)
        
        couponView = UIImageView(image: UIImage(named: "coupon.png"))
        couponView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    //검색 결과를 저장할 프로퍼티를 생성
    var matchingItems = [MKMapItem]()
    
    //검색을 수행해주는 사용자 정의 함수
    func performSearch(){
        //기본 배열의 값을 모두 삭제
        matchingItems.removeAll()
        //로컬 검색 객체 생성
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response:MKLocalSearch.Response!, error:Error!) in
            //에러가 발생한 경우
            if error != nil{
                NSLog("Error:\(error.localizedDescription)")
            }else if response.mapItems.count == 0{
                NSLog("검색된 데이터가 없음")
            }else {
                NSLog("데이터 검색 성공")
                //결과를 순회
                for item in response.mapItems as [MKMapItem]{
                    if item.name != nil{
                        NSLog("이름=\(item.name!)")
                    }
                    if item.phoneNumber != nil {
                        NSLog("전화번호=\(item.phoneNumber!)")
                    }
                    
                    //지도에 마커 출력
                    self.matchingItems.append(item as MKMapItem)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                }
                
                //하위 데이터를 출력할 뷰 컨트롤러를 생성해서 데이터를 전달
                let destination = self.storyboard?.instantiateViewController(identifier: "ResultListVC") as! ResultListVC
                
                destination.title = self.searchText.text
                destination.mapItem = self.matchingItems
                self.navigationController?.pushViewController(destination, animated: true)
            }
        })
    }

    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func textFieldReturn(_ sender: Any) {
        searchText.resignFirstResponder()
        //mapView.removeAnnotation(mapView.annotations)
        self.performSearch()
    }
    
}

extension ViewController : MKMapViewDelegate, CLLocationManagerDelegate{
    //사용자의 위치가 변경될 때 호출될 메소드
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    //영역에 들어왔을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        mapView.addSubview(couponView)
    }
    
    //영역에서 벗어날 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion){
        couponView.removeFromSuperview()
    }
}
