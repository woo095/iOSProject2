//
//  SceneDelegate.swift
//  notification
//
//  Created by Sinchon on 2021/04/22.
//

import UIKit

//로컬 알림을 사용하기 위한 프레임워크 import
import UserNotifications

//이 클래스는 앱이 실행될 때 AppDelegate 가 호출되고
//화면에 보여지기 전에 호출되서 화면을 만드는 역할 하는 클래스
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        //알림창 등록
        let notificationCenter = UNUserNotificationCenter.current()
        
        //알림 권한 신청
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(didAllow, e) -> Void in})
        
        //알림이 왔을 때 호출될 메소드의 위치를 설정
        notificationCenter.delegate = self
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {(settings) -> Void in
            //알림을 사용할 권한이 있다면
            if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                let nContent = UNMutableNotificationContent()
                nContent.badge = 1
                nContent.title = "로컬 알림 메시지"
                nContent.subtitle = "하위 제목"
                nContent.body = "메시지 내용 입니다."
                nContent.sound = UNNotificationSound.default
                
                //부가 정보 - 알림 객체에게 전달할 데이터
                nContent.userInfo = ["name":"관리자"]
                
                //알림 발생 조건 생성
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
                
                //알림 요청 객체 생성
                let request = UNNotificationRequest(identifier: "구별할 이름", content: nContent, trigger: trigger)
                
                //알림을 등록
                UNUserNotificationCenter.current().add(request)
            } else {
                NSLog("알림 사용 권한을 선택하지 않았습니다.")
            }
        })
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
    }


}

//UNUserNotificationCenterDelegate 메소드 구현을 위한 extension
extension SceneDelegate : UNUserNotificationCenterDelegate{
    //알림이 호면 호출되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //알림이 오면
        if notification.request.identifier == "구별할이름"{
            let userInfo = notification.request.content.userInfo
            NSLog("\(userInfo["name"])")
        }
        
        completionHandler([.badge, .banner, .sound])
        
    }
    
    //알림 메시지를 누르면 호출되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "구별할이름"{
            let userInfo = response.notification.request.content.userInfo
            NSLog("\(userInfo["name"])")
        }
        
        completionHandler()
    }
}
