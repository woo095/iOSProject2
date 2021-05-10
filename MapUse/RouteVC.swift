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

        routeMap.delegate = self
        routeMap.showsUserLocation = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
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
}
