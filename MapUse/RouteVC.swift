//
//  RouteVC.swift
//  MapUse
//
//  Created by Sinchon on 2021/05/10.
//

import UIKit
import MapKit

class RouteVC: UIViewController {

    @IBOutlet weak var routeMap: MKMapView!
    
    //하나의 위치 정보를 저장할 프로퍼티 - 이전 뷰 컨트롤러에서 전달
    var destination:MKMapItem?
    
    //현재 위치를 저장할 프로퍼티
    var userLocation:CLLocation?
    
    //위치 정보 사용을 위한 객체 생성
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //맵뷰에 이벤트가 발생하면 현재 클래스의 인스턴스가 처리
        routeMap.delegate = self
        //맵뷰가 현재 위치를 사용
        routeMap.showsUserLocation = true
        
        //위치 정보의 정밀도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 정보에 이벤트가 발생하면 현재 클래스의 인스턴스가 처리
        locationManager.delegate = self
        //위치 정보를 사용하는 시점을 설정
        locationManager.requestLocation()
        
        routeMap.mapType = .hybridFlyover
        
        var coordinate : CLLocationCoordinate2D?
        if userLocation != nil{
            coordinate = userLocation!.coordinate
        } else {
            coordinate = CLLocationCoordinate2D(latitude: 37.4, longitude: 127.027621)
        }
        // Do any additional setup after loading the view.
        
        camera = MKMapCamera(lookingAtCenter: coordinate!, fromDistance: distance, pitch: pitch, heading: heading)
        
        routeMap.camera = camera!
    }
    
    //플라이오버를 위한 프로퍼티
    let distance : CLLocationDistance = 650
    let pitch : CGFloat = 65
    let heading = 0.0
    var camera : MKMapCamera?
    @IBAction func animateCamera(_ sender: Any) {
        UIView.animate(withDuration: 20, animations: {
            self.camera!.heading += 100
            self.camera!.pitch = 25
            self.routeMap.camera = self.camera!
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RouteVC : MKMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //현재 위치 변경
        userLocation = locations[0]
        //사용자 정의 메소드 호출
        self.getDirections()
    }
    
    //위치 정보를 가져오는데 실패했을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(error.localizedDescription)
    }
    
    //MapView
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.blue
        render.lineWidth = 5.0
        return render
    }
    
    //사용자 정의 메소드 - 사용자 정의 메소드를 2개로 분할
    //하나로 만들어도 되지만 코드가 너무 길어지고 코드가 길어지면 일기가 어려워지고 읽기가 어려워지면 유지보수가 어렵기 때문입니다.
    
    func showRoute(_ response:MKDirections.Response){
        //경로를 받아 순서대로
        for route in response.routes{
            //맵뷰 위에 선을 그려달라고 요청
            routeMap.addOverlay(route.polyline, level:MKOverlayLevel.aboveRoads)
            
            //동선을 문자열로 출력
            for step in route.steps{
                NSLog(step.instructions)
            }
        }
        
        //맵 뷰의 출력 영역을 변경
        if let coordinate = userLocation?.coordinate{
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            routeMap.setRegion(region, animated: true)
        }
    }
    
    func getDirections(){
        //출발지와 목적지 정보 설정
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        
        if let destination = destination{
            request.destination = destination
        }
        
        //반대편 방향은 사용하지 않음
        request.requestsAlternateRoutes = false
        
        //요청
        let directions = MKDirections(request: request)
        
        //요청 결과 사용
        directions.calculate(completionHandler: {(response, error) in
            if let error = error{
                NSLog(error.localizedDescription)
            } else {
                if let response = response{
                    self.showRoute(response)
                }
            }
        })
    }
}
