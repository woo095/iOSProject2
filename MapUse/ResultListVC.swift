//
//  ResultListVC.swift
//  MapUse
//
//  Created by Sinchon on 2021/05/10.
//

import UIKit
import MapKit

class ResultListVC: UITableViewController {

    //이전 뷰 컨트롤러로부터 데이터를 넘겨받을 프로퍼티
    var mapItem:[MKMapItem]?
    
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
        //mapItem 이 nil 이면 0
        return mapItem?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")
        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ResultCell")
        }
        
        if let item = mapItem?[indexPath.row]{
            cell?.textLabel?.text = item.name
            cell?.detailTextLabel?.text = item.phoneNumber
        }

        // Configure the cell...

        return cell!
    }
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let routeVC = self.storyboard?.instantiateViewController(identifier: "RouteVC") as! RouteVC
        let destination = mapItem?[indexPath.row]
        routeVC.destination = destination
        self.navigationController?.pushViewController(routeVC, animated: true)
    }

}
