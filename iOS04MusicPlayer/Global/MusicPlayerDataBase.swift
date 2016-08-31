//
//  MusicPlayerDataBase.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/8/2.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit
import FMDB
class MusicPlayerDataBase: NSObject {
  
    var dataBase:FMDatabase?
    //表明
    var myTableName:String?
    
    
    static var shareMusicDataBase:MusicPlayerDataBase = {
        let instance = MusicPlayerDataBase()
        return instance
    }()
    
    func openDataBase(){
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let dataBasepath = documentPath.stringByAppendingString("/music.sqlite")
        print("数据库路径----\(dataBasepath)")
        dataBase = FMDatabase(path:dataBasepath)
    }
    
    func creatDataBaseTable(tableName:String){
        if dataBase == nil {
            openDataBase()
        }
        myTableName = tableName
        if dataBase?.open() == true {
            let creatTableSqlite = "CREATE TABLE \(tableName)(ID Integer PRIMARY KEY,SongName TEXT ,SingerName TEXT,SongImage TEXT,Lrcy TEXT,SongUrl TEXT) "
            let result = dataBase?.executeStatements(creatTableSqlite)
            if result == true {
                print("建表成功")
            }else{
                print("创建table出错或者table已经存在")
            }
        }
    }
    
    func insertPlayModel(playModel:PlayModel){
        if dataBase?.open() == true {
            let insertSqlite = "insert into \(myTableName ?? "musicTable")(ID,SongName,SingerName,SongImage,Lrcy,SongUrl)values(?,?,?,?,?,?)"
            do{
             try dataBase?.executeUpdate(insertSqlite,values:[playModel.song_id!, playModel.title!, playModel.author!, playModel.pic_radio!, playModel.lrclink!, playModel.file_link!])
            
          }catch{
            print("插入数据失败")
          }
        }
    }
    
    func deletePlayModel(song_id:String){
        if dataBase?.open() == true{
            let deleteSqlite = "delete from \(myTableName ?? "musicTable") where ID = ?"
            do{
                try dataBase?.executeUpdate(deleteSqlite, values: [song_id])
            }catch{
                print("删除失败")
            }
        }
    }        
    func selectAllModels() -> [PlayModel]{
        var allModels = [PlayModel]()
        if dataBase?.open() == true {
            let selectSqilte = "select * from \(myTableName ?? "musicTable")"
            let resultSet = dataBase?.executeQuery(selectSqilte, withArgumentsInArray:["musicTable"])
            while resultSet?.next() == true {
                let playModel = PlayModel()
                playModel.song_id = resultSet?.stringForColumn("ID")
                playModel.title = resultSet?.stringForColumn("SongName")
                playModel.author = resultSet?.stringForColumn("SingerName")
                playModel.pic_radio = resultSet?.stringForColumn("SongImage")
                playModel.file_link = resultSet?.stringForColumn("SongUrl")
                playModel.lrclink = resultSet?.stringForColumn("Lrcy")
                allModels.append(playModel)
                }
            }
        return allModels
    }
}





