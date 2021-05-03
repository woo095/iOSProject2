//
//  ToDoInputVC.swift
//  CoreDataToDo
//
//  Created by Sinchon on 2021/05/03.
//

import UIKit

class ToDoInputVC: UIViewController {

    @IBOutlet weak var dpRuntime: UIDatePicker!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvContents: UITextView!
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSave(_ sender: Any) {
        let title = tfTitle.text
        let contents = tvContents.text
        let runtime = dpRuntime.date
        
        //자신을 출력한 뷰 컨트롤러 찾아오기
        //NavigationController를 이용해서 이동한 경우
        
        let navVC = self.presentationController as! UINavigationController
        let toDoListVC = navVC.topViewController as! ToDoListVC
        
        //데이터 삽입하는 메소드 호출
        let result = toDoListVC.save(title: title!, contents: contents!, runtime: runtime)
        
        if result == true{
            NSLog("데이터 삽입 성공")
        }else{
            NSLog("데이터 삽입 실패")
        }
        
        //이전 뷰 컨트롤러로 이동
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
