//
//  MusicListDetailController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/26.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class MusicListDetailController: UITableViewController {

    var stringID: String?
    var imgStr: String?
    var typeString: String?
    var tingUid: String?
    var scene_id: String?
    let commonSongPlayerCell = "CommonSongPlayerCell"
    
    lazy var musicListDetailArray:[SongModel] = {
        var musicListDetailArray = [SongModel]()
        return musicListDetailArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurStyle = UIBlurEffect(style: .Dark)
        let visualView = UIVisualEffectView(effect: blurStyle)
        visualView.frame = UIScreen.mainScreen().bounds
        tableView.backgroundView = visualView
        
        tableView.registerNib(UINib(nibName: "CommonSongPlayerCell",bundle: NSBundle.mainBundle()),forCellReuseIdentifier: commonSongPlayerCell)
        
        if stringID != nil {
            creatView()
        }else if typeString != nil{
            addMusicListView()
        }else if tingUid != nil{
            addSingerListView()
        }else{
            addSmallCategoryListView()
        }
    }
    
//    根据playModel来设置UI控件信息
        
    private func creatView(){
        NetWorkTool.shareNetWorkTool.httpRequest(.post, urlString: homePageHotDetailUrl, parameter: ["method":"baidu.ting.diy.gedanInfo","from":"ios", "listid":stringID!, "verson":"5.2.3",  "channel":"appstore"]) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("网络较差")
                return
            }
            for dict in receiveData["content"] as! [[String:AnyObject]]{
                let musicListModel = SongModel(dict:dict)
                self.musicListDetailArray.append(musicListModel)
            }
            let imageV = UIImageView(frame: CGRectMake(0, 0, screenWidth, 250))
            imageV.sd_setImageWithURL(NSURL(string:self.imgStr!))
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                self.tableView.tableHeaderView = imageV
            }
        }
    }
    
    func addMusicListView(){
        let topMusicListUrl = rankingMusicListOne + typeString! + rankingMusicListTwo
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: topMusicListUrl, parameter:nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("网络较差")
                return
            }
            for dict in receiveData["song_list"] as! [[String:AnyObject]]{
                let musicListModel = SongModel(dict:dict)
                self.musicListDetailArray.append(musicListModel)
            }
            let imageV = UIImageView(frame: CGRectMake(0, 0, screenWidth, 250))
            imageV.sd_setImageWithURL(NSURL(string:self.imgStr!))
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                self.tableView.tableHeaderView = imageV
            }
        }
    }
    
    func addSingerListView(){
        let singerListUrl = rankingSingerListUrlOne + tingUid! + rankingSingerListUrlTwo
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: singerListUrl as String, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("歌手歌曲数据解析错误")
                return
            }
            for dict in receiveData["songlist"] as! [[String:AnyObject]]{
                let musicListModel = SongModel(dict:dict)
                self.musicListDetailArray.append(musicListModel)
            }
            let imageV = UIImageView(frame: CGRectMake(0, 0, screenWidth, 250))
            imageV.sd_setImageWithURL(NSURL(string:self.imgStr!))
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                self.tableView.tableHeaderView = imageV
            }
        }
    }
    
    func addSmallCategoryListView(){
        let smallCategoryListUrl:NSString = NSString(format: smallCategoryUrl, scene_id!)
        print(smallCategoryListUrl)
        print(scene_id!)
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: smallCategoryListUrl as String, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("歌手歌曲数据解析错误")
                return
            }
            for dict in receiveData["result"]!!["songlist"] as! [[String:AnyObject]]{
                let musicListModel = SongModel(dict:dict)
                self.musicListDetailArray.append(musicListModel)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
                let imageV = UIImageView(frame: CGRectMake(0, 0, screenWidth, 250))
                imageV.sd_setImageWithURL(NSURL(string:self.imgStr!))
                self.tableView.tableHeaderView = imageV
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MusicListDetailController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListDetailArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier(commonSongPlayerCell, forIndexPath: indexPath) as! CommonSongPlayerCell
        let model = musicListDetailArray[indexPath.row]
        cell.countLabel.text = String(indexPath.row + 1)
        cell.backgroundColor = UIColor.clearColor()
        cell .setValueWithModel(model)
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MusicPlayer.shareMusicPlayer.index = indexPath.row
        MusicPlayer.shareMusicPlayer.songModels = musicListDetailArray
        
//        跳转页面
        let musicPlayerVC = CommonMusicPlayController()
        let model:SongModel = musicListDetailArray[indexPath.row]
        musicPlayerVC.backImageV.sd_setImageWithURL(NSURL(string: self.imgStr!))
        musicPlayerVC.titleString = model.title!
        musicPlayerVC.authorString = model.author!
        presentViewController(musicPlayerVC, animated: true, completion: nil)
    }
}

