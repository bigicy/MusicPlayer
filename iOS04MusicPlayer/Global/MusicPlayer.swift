//
//  MusicPlayer.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/28.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

protocol MusicPlayerDelegate {
    func autoRefreshProgress(progress:Float);
}

class MusicPlayer: NSObject {
//    当前播放的歌曲是当前列表的第几首
    var index:Int?
//    当前列表的所有歌曲的模型
    var songModels:[SongModel]?
//    是否可以播放的标志位
    var readToPlay:Bool?
//    播放器
    lazy var myAvPlayer:AVPlayer = {
        let avPlayer = AVPlayer()
        return avPlayer
    }()
//    当前播放的Item
    var playerItem:AVPlayerItem?
    
    //    音乐播放单利工具类
    static var shareMusicPlayer:MusicPlayer = {
        let instance = MusicPlayer()
//      AVPlayerItem: 播放结束系统内部会发送一个AVPlayerItemDidPlayToEndTimeNotification的通知
        NSNotificationCenter.defaultCenter().addObserver(instance, selector: #selector(MusicPlayer.playNextSong), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
//        打开数据库
       MusicPlayerDataBase.shareMusicDataBase.openDataBase()
//        创建表格
       MusicPlayerDataBase.shareMusicDataBase.creatDataBaseTable("musicTable")
        
    MusicPlayerDataBase.shareMusicDataBase.creatDataBaseTable("downLoadTable")
        return instance
    }()
    
    func playNextSong(){
        switch playStyle! {
        case 0:
            print("循环播放")
            playRound()
        case 1:
            print("单曲循环")
            playSingle()
        case 2:
            print("随机播放")
            playRandom()
        case 3:
            print("顺序播放")
            playOrder()
        default:
            print("unKnown")
        }
    }
//    单曲循环
    private func playSingle(){
       playMusic((playModel?.file_link)!)
    }
//    循环播放
    private func playRound(){
        index = index! == (songModels?.count)! - 1 ? 0 : index! + 1
        loadSongInfo()
    }

//    顺序播放
    private func playOrder(){
        if index! == (songModels?.count)! - 1{
            myAvPlayer.pause()
        }else{
            index! += 1
            loadSongInfo()
        }
    }
//    随机播放
    private func playRandom(){
       let tempIndex = arc4random_uniform(UInt32((songModels?.count)!))
        index = Int(tempIndex)
        loadSongInfo()
    }
//    下载歌曲
    func downloadMusic(){
        if let tempModel = playModel{
            MusicPlayerDownLoad.shareMusicPlayerDownLoad.creatDownLoadTask(tempModel)
        }
    }
    
//   根据song_ID解析出来的模型
    var playModel:PlayModel?
    
//    创建定时器
    var timer: NSTimer?
//    定义代理属性
    var delegate: MusicPlayerDelegate?
   
    var playStyle: Int?
    
    func loadSongInfo(){
//    取出当前歌曲的模型
        let songModel = songModels![index!]
        let songPlayUrl = songUrlOne + songModel.song_id! + songUrlTwo
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: songPlayUrl, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("解析歌曲出错")
                return
            }
            let songInfo = receiveData["songinfo"] as! [String:AnyObject]
            let songUrlList = receiveData["songurl"]!!["url"] as! [[String:AnyObject]]
            let songUrl = songUrlList[0]
            self.playModel = PlayModel(songinfo: songInfo, songurl: songUrl)
//            设置锁屏信息
            self.setLockScreenInfo(self.playModel!)
//            发送通知
       NSNotificationCenter.defaultCenter().postNotificationName("openLyricMusic", object: nil)
//            插入数据库
            MusicPlayerDataBase.shareMusicDataBase.insertPlayModel(self.playModel!)
//            发送通知
            NSNotificationCenter.defaultCenter().postNotificationName("loadData", object: nil)
            self.playMusic(self.playModel!.file_link!)
        }
    }
//    设置锁屏的方法
    func setLockScreenInfo(playModel:PlayModel){
//        MPNowPlayingInfoCenter 播放中心记录了当前正在播放的歌曲信息
         MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = nil
        var dict = [String:AnyObject]()
//        设置歌手名
        dict[MPMediaItemPropertyArtist] = playModel.author
//        设置歌名
        dict[MPMediaItemPropertyTitle] = playModel.title
//        设置专辑缩略图
        var imageData = NSData(contentsOfURL: NSURL(string: playModel.pic_radio!)!)
        if imageData == nil{
            imageData = UIImagePNGRepresentation(UIImage(named: "3.jpg")!)
            print(imageData)
            let artWork = MPMediaItemArtwork(image: UIImage(data: imageData!)!)
            dict[MPMediaItemPropertyArtwork] = artWork
            //        设置给播放中心
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = dict
        }else{
         let artWork = MPMediaItemArtwork(image: UIImage(data: imageData!)!)
        dict[MPMediaItemPropertyArtwork] = artWork
//        设置给播放中心
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = dict
        }
    }
    
//    根据fileLink参数来播放歌曲
    func playMusic(fileLink: String){
//        移除上一首歌曲的观察者，防止出现野指针
        if playerItem != nil{
          playerItem?.removeObserver(self, forKeyPath: "status")
        }
        playerItem = AVPlayerItem(URL: NSURL(string: fileLink)!)
//        添加观察者, 观察歌曲加载的过程
        playerItem?.addObserver(self, forKeyPath: "status", options: [.New,.Old], context: nil)
        myAvPlayer.replaceCurrentItemWithPlayerItem(playerItem)
    }
//    监测歌曲加载的过程
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        switch change!["new"]!.integerValue{
        case AVPlayerItemStatus.Failed.rawValue:
            print("歌曲缓冲失败")
        case AVPlayerItemStatus.ReadyToPlay.rawValue:
            print("歌曲缓冲成功")
            readToPlay = true
//            播放歌曲
            startPlayMusic()
//            发送通知
       NSNotificationCenter.defaultCenter().postNotificationName("readToPlay", object: nil)
        case AVPlayerItemStatus.Unknown.rawValue:
            print("缓冲状态未知")
        default:
            print("default")
        }
    }
//    开始播放歌曲
    func startPlayMusic(){
        if readToPlay == true {
//            销毁定时器
//            timer?.invalidate()
//            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(MusicPlayer.timeAction), userInfo: nil, repeats: true)
            myAvPlayer.play()
            readToPlay = false
        }
    }
    func timeAction(){
        let time = Int((playerItem?.currentTime().value)!)
        let timeScale = Int((playerItem?.currentTime().timescale)!)
        let progress = Float(time/timeScale)
        delegate?.autoRefreshProgress(progress)
    }
    
//    停止播放歌曲
    func stopPlayMusic(){
        myAvPlayer.pause()
        readToPlay = true
    }
//    播放/暂停歌曲
    func playOrPauseMusic(){
        if readToPlay == true {
           startPlayMusic()
        }else{
           stopPlayMusic()
        }
    }
//    上一首
    func playPreviousMusic(){
        if index == 0 {
            index = (songModels?.count)!-1
        }else{
            index = index!-1
        }
        loadSongInfo()
    }
//    下一首
    func playNextMusic(){
        index = index! == (songModels?.count)! - 1 ? 0 : index! + 1
        loadSongInfo()
    }
    
//    播放进度
    func musicPlayerWithSliderProgress(progress:Float){
        myAvPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(progress), playerItem!.currentTime().timescale)) { (true) in
//            self.startPlayMusic()
        }
    }
}







 