//
//  ToDoListVC.swift
//  CoreDataToDo
//
//  Created by Sinchon on 2021/05/03.
//

import UIKit
import CoreData

class ToDoListVC: UITableViewController {
    
    
    
    //데이터 저장을 위한 메소드
    func save(title:String, contents:String, runtime:Date) -> Bool{
        let appDeleagte = UIApplication.shared.delegate as! AppDelegate
        let context = appDeleagte.persistentContainer.viewContext
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        
        //데이터 설정
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue
        
        //1:N 관계의 데이터 삽입
        (object as! ToDoMO).addToLogs(logObject)
        
        do{
            try context.save()
            self.list.append(object)
            self.list = self.fetch()
            return true
        } catch{
            context.rollback()
            return false
        }
    }
    
    //코어 데이터 삭제를 위한 메소드
    func delete(object:NSManagedObject) -> Bool{
        //데이터 편집을 위한 관리 객체 컨텍스트를 생성
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        //데이터 삭제
        context.delete(object)
        
        do{
            try context.save()
            return true
        }catch {
            context.rollback()
            return false
        }
    }
    
    
    func fetch() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //요청 객체 생성 - ToDo Entity의 데이터를 가져오도록 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
        
        //데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    //데이터 수정을 위한 메소드
    func edit(object:NSManagedObject, title:String, contents:String, runtime:Date) -> Bool{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        
        //데이터 설정
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue
        
        //1:N 관계의 데이터 삽입
        (object as! ToDoMO).addToLogs(logObject)
        
        do{
            //데이터를 반영
            try context.save()
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()
    
    @IBAction func add(_ sender: Any){
        let toDoInputVC = self.storyboard?.instantiateViewController(identifier: "ToDoInputVC") as! ToDoInputVC
        
        toDoInputVC.mode = "삽입"
        
        self.navigationController?.pushViewController(toDoInputVC, animated: true)
    }

    //처음 보여질때
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       /* let alert = UIAlertController(title: "viewDidLoad", message: "뷰가 만들어 질때 호출되는 메소드", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)*/
        
        //제목 설정
        self.title = "ToDo"
        //네비게이션 바의 왼쪽에 edit 버튼 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        //셀을 스와이프로 삭제할 수 있게 해주는 설정
        self.tableView.allowsSelectionDuringEditing = true
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let object = list[indexPath.row]
        
        //출력할 하위 뷰 컨트롤러를 생성합니다.
        let logVC = self.storyboard?.instantiateViewController(identifier: "LogVC") as! LogVC
        
        //데이터 전달
        logVC.toDo = object as? ToDoMO
        
        //하위 뷰 컨트롤러를 네비게이션 컨트롤러를 이용해서 출력
        self.navigationController?.pushViewController(logVC, animated: true)
    }
    
    //다른 뷰를 갔다 오면
    //뷰가 화면에 보여질 때 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*let alert = UIAlertController(title: "viewWillAppear", message: "뷰가 보여 질때 호출되는 메소드", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)*/
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cellIdentifier = "ToDoCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }

        // Configure the cell...
        
        let record = list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        let runtime = record.value(forKey: "runtime") as? Date
        
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = contents

        return cell!
    }
    
    //edit 버튼을 눌렀을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //edit를 누르고 - 버튼을 누른 후 delete 버튼을 눌렀을때 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //삭제할 데이터 가져오기
        let object = self.list[indexPath.row]
        
        //데이터 삭제
        if self.delete(object: object){
            self.list.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    //셀을 선택했을 때 호출되는 메소드 - 수정을 위해서 ToDoInputVC를 호출
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        let runtime = object.value(forKey: "runtime") as? Date
        
        let toDoInputVC = self.storyboard?.instantiateViewController(identifier: "ToDoInputVC") as! ToDoInputVC
        
        toDoInputVC.object = object
        toDoInputVC.t = title!
        toDoInputVC.c = contents!
        toDoInputVC.r = runtime!
        toDoInputVC.mode = "수정"
        
        //출력
        self.navigationController?.popViewController(animated: true)
    }
}
