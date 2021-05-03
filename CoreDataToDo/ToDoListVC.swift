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
    
    func fetch() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //요청 객체 생성 - ToDo Entity의 데이터를 가져오도록 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
        
        //데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()
    
    @IBAction func add(_ sender: Any){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
}
