//
//  PhoneBookDAO.swift
//  SQLitePhoneBook
//
//  Created by Sinchon on 2021/05/03.
//

import UIKit

class PhoneBookDAO {

    //DTO 역할을 수행할 튜플의 이름 설정
    //정수 1개(번호)와 문자열 3개(이름, 전화번호, 주소)로 구성
    typealias PhoneRecord = (Int, String, String, String)
    
    //SQLite 연결 및 초기화
    //lazy는 지연생성 - 처음부터 만들지 않고 처음 사용할 때 생성
    lazy var fmdb:FMDatabase! = {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        let dbPath = docsDir.appending("/phonebook.sqlite")
        
        let fileMgr = FileManager.default
        
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    //초기화 메소드
    init(){
        self.fmdb.open()
    }
    
    //소멸자 메소드
    deinit {
        self.fmdb.close()
    }
    
    //전체 데이터를 읽어오는 메소드
    func find() -> [PhoneRecord]{
        var phoneList = [PhoneRecord]()
        
        do{
            //전체 데이터 읽어오는 SQL
            let sql = "select num, name, phone, addr from phonebook order by num asc"
            
            //sql 실행
            let rs = try self.fmdb.executeQuery(sql, values: nil);
            
            while rs.next(){
                let num = rs.int(forColumn: "num")
                let name = rs.string(forColumn: "name")
                let phone = rs.string(forColumn: "phone")
                let addr = rs.string(forColumn: "addr")
                
                //하나의 행 만들기
                let record = (Int(num), name!, phone!, addr!)
                
                //배열 추가
                phoneList.append(record)
            }
        }catch let error as NSError{
            NSLog("데이터 전체 일기 실패:\(error.localizedDescription)")
        }
        
        return phoneList
    }
    
    func get(num:Int) -> PhoneRecord?{
        var record:PhoneRecord? = nil
        
        //SQL 생성
        let sql = "select num, name, phone, addr from phonebook where num=?"
        
        //SQL 실행
        let rs =  self.fmdb.executeQuery(sql, withArgumentsIn: [num])
        
        if rs?.next() == true{
            let num = rs?.int(forColumn: "num")
            let name = rs?.string(forColumn: "name")
            let phone = rs?.string(forColumn: "phone")
            let addr = rs?.string(forColumn: "addr")
            
            record = (Int(num!), name!, phone!, addr!)
        }
        
        return record
    }
    
    //데이터 삽입
    func create(name:String!, phone:String!, addr:String!) -> Bool{
        do{
            let sql = "insert into phonebook(name, phone, addr) values(?,?,?)"
            
            try self.fmdb.executeUpdate(sql, values: [name!, phone!, addr!])
            
            return true
        }catch let error as NSError{
            NSLog("삽입 예외: \(error.localizedDescription)")
            return false
        }
    }
    
    func delete(num:Int) -> Bool{
        do{
            let sql = "delete from phonebook where num = ?"
            
            try self.fmdb.executeUpdate(sql, values: [num])
            
            return true
        }catch let error as NSError{
            NSLog("삭제 예외: \(error.localizedDescription)")
            return false
        }
    }
}
