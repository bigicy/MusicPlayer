//
//  CommonMusicPlayController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/28.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit
import MediaPlayer
class CommonMusicPlayController: UIViewController {

    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sliderProgress: UISlider!
    var timer: NSTimer?
    var titleString: String?
    var authorString: String?
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var timeArray:[NSString] = {
        let timeArray = [NSString]()
        return timeArray
    }()
    
    lazy var lyricArray:[NSString] = {
        let lyricArray = [NSString]()
        return lyricArray
    }()
    
    lazy var backImageV:UIImageView = {
        let backImageV = UIImageView(frame: CGRectMake(50, 16, 300, 300))
        return backImageV
    }()
    
    lazy var lyricTableView:UITableView = {
        let tableView = UITableView(frame: CGRectMake(screenWidth , 0, screenWidth + 30 , 460), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgV = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        imgV.image = UIImage(named: "方向.jpg")
        view.insertSubview(imgV, atIndex: 0)
        let toolBar = UIToolbar(frame: imgV.frame)
        toolBar.barStyle = .BlackTranslucent
        imgV.addSubview(toolBar)
        lyricTableView.reloadData()
        musicTitle.text = titleString
        authorLabel.text = authorString
        MusicPlayer.shareMusicPlayer.playStyle = 0
//        加载音频歌曲
        if MusicPlayer.shareMusicPlayer.playModel?.title != musicTitle.text  {
             MusicPlayer.shareMusicPlayer.loadSongInfo()
        }
        print(MusicPlayer.shareMusicPlayer.playModel?.title)
        print(musicTitle.text)
        backImageV.layer.cornerRadius = backImageV.frame.size.width/2
        backImageV.layer.masksToBounds = true
        
        sliderProgress.value = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(CommonMusicPlayController.timerAction), userInfo: nil, repeats: true)
//        设置代理
//        MusicPlayer.shareMusicPlayer.delegate = self
//         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommonMusicPlayController.reloadDataWithModel), name: "loadData", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommonMusicPlayController.startPlayMusic), name: "readToPlay", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommonMusicPlayController.playMusicWithLyric), name: "openLyricMusic", object: nil)
        creatScrollView()
    }
    func creatScrollView(){
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(2*screenWidth, 0)
        scrollView.contentOffset = CGPointMake(0, 0)
        scrollView.addSubview(backImageV)
        scrollView.addSubview(lyricTableView)
    }
    
    func reloadDataWithModel(){
        let playModel = MusicPlayer.shareMusicPlayer.playModel
        backImageV.sd_setImageWithURL(NSURL(string: (playModel?.pic_radio)!))
        musicTitle.text = playModel?.title
        authorLabel.text = playModel?.author
        timeLabel.text = setTime(Float((playModel?.file_duration)!))
        sliderProgress.maximumValue = Float((playModel?.file_duration)!)
    }
//    开始播歌, 切换按钮的图标
    func startPlayMusic(){
        if MusicPlayer.shareMusicPlayer.readToPlay == true {
            playButton.setImage(UIImage(named: "player_pause@2x"), forState: .Normal)
        }else{
            playButton.setImage(UIImage(named: "player_play"), forState: .Normal)
        }
    }

    func setTime(progress:Float) -> String{
        let min = Int(progress)/60
        let sec = Int(progress)%60
        let timeStr = String(format: "%02d:%02d", min,sec)
        return timeStr
    }
    
    func timerAction(){
        if MusicPlayer.shareMusicPlayer.myAvPlayer.currentTime().timescale == 0||MusicPlayer.shareMusicPlayer.myAvPlayer.currentItem?.duration.timescale == 0 {
            return
        }
        let currentTime = MusicPlayer.shareMusicPlayer.myAvPlayer.currentTime().value/Int64(MusicPlayer.shareMusicPlayer.myAvPlayer.currentTime().timescale) 
        startLabel.text = NSString(format: "%02lld:%02lld", currentTime/60, currentTime%60) as String
        let allTime = (MusicPlayer.shareMusicPlayer.myAvPlayer.currentItem?.duration.value)!/Int64((MusicPlayer.shareMusicPlayer.myAvPlayer.currentItem?.duration.timescale)!)
        timeLabel.text = NSString(format: "%02lld:%02lld", allTime/60, allTime%60) as String
        sliderProgress.value = Float(currentTime)
        sliderProgress.maximumValue = Float(allTime)
        sliderProgress.minimumValue = 0
        
        if sliderProgress.value == Float(allTime) {
            MusicPlayer.shareMusicPlayer.playNextMusic()
            replaceItemWithIndex(MusicPlayer.shareMusicPlayer.index!)
        }
        if MusicPlayer.shareMusicPlayer.myAvPlayer.rate == 1.0{
            backImageV.transform = CGAffineTransformRotate(backImageV.transform, 0.1)
        }
        for i in 0..<timeArray.count {
            let timeString = setTime((timeArray[i] as NSString).floatValue)
            if timeString == setTime(Float(currentTime)){
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                if lyricTableView.numberOfRowsInSection(0) > 0{
                    lyricTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
                    let cell = lyricTableView.cellForRowAtIndexPath(indexPath)
                    cell?.textLabel?.textColor = UIColor.purpleColor()
                    cell?.textLabel?.font = UIFont.systemFontOfSize(22, weight: 1)
                }
            }else{
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let cell = lyricTableView.cellForRowAtIndexPath(indexPath)
                    cell?.textLabel?.textColor = UIColor.whiteColor()
                    cell?.textLabel?.font = UIFont.systemFontOfSize(17, weight: 1)
            }
        }
        
        
        let dict = MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo
        if var tempDict = dict{
//            设置总时长
//            MPMediaItemPropertyPlaybackDuration 在OC中对应的value采用NSNumber来包装，在swift中采用基本数据类型float和double
            let duration = CMTimeGetSeconds((MusicPlayer.shareMusicPlayer.myAvPlayer.currentItem?.duration)!)
            tempDict[MPMediaItemPropertyPlaybackDuration] = duration
//            设置当前播放时间 对应的key值为
//            MPNowPlayingInfoPropertyElapsedPlaybackTime ,OC中写法与swift的差别同上
            let currentTime = CMTimeGetSeconds((MusicPlayer.shareMusicPlayer.myAvPlayer.currentItem?.currentTime())!)
            tempDict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
//            播放速率
            tempDict[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = tempDict
        }
    }
    
//    返回
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    控制播放进度
    @IBAction func sliderAction(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        MusicPlayer.shareMusicPlayer.musicPlayerWithSliderProgress(slider.value)
    }
//    播放/暂停按钮
    @IBAction func playOrPauseAction(sender: AnyObject) {
        let button = sender as! UIButton
        if MusicPlayer.shareMusicPlayer.readToPlay == true {
            button.setImage(UIImage(named: "player_pause"), forState: .Normal)
        }else{
            button.setImage(UIImage(named: "player_play"), forState: .Normal)
        }
        MusicPlayer.shareMusicPlayer.playOrPauseMusic()
    }
//    上一首
    @IBAction func playPreviousAction(sender: AnyObject) {
        MusicPlayer.shareMusicPlayer.playPreviousMusic()
        replaceItemWithIndex(MusicPlayer.shareMusicPlayer.index!)
    }
//   下一首
    @IBAction func playNextAction(sender: AnyObject) {
        MusicPlayer.shareMusicPlayer.playNextMusic()
        replaceItemWithIndex(MusicPlayer.shareMusicPlayer.index!)
    }
//    顺序播放
    @IBAction func playAroundAction(sender: AnyObject) {
        
        let imageNames = ["bt_playpagen_control_round-all_normal","bt_playpagen_control_round-one_normal","bt_playpagen_control_random_normal","bt_playpagen_control_order_normal"]
        let button:UIButton = sender as! UIButton
        if MusicPlayer.shareMusicPlayer.playStyle == 3 {
            MusicPlayer.shareMusicPlayer.playStyle = 0
        }else{
            MusicPlayer.shareMusicPlayer.playStyle = (MusicPlayer.shareMusicPlayer.playStyle!) + 1
        }
        button.setImage(UIImage(named:imageNames[MusicPlayer.shareMusicPlayer.playStyle!]), forState: .Normal)
    }
    
//    下载歌曲
    @IBAction func playDownLoadAction(sender: AnyObject) {
        MusicPlayer.shareMusicPlayer.downloadMusic()
    }
    
    func playMusicWithLyric(){
        let index = MusicPlayer.shareMusicPlayer.index
        let model:SongModel = MusicPlayer.shareMusicPlayer.songModels![index!]
        musicTitle.text = model.title
        authorLabel.text = model.author
        let playModel = MusicPlayer.shareMusicPlayer.playModel
        let result = LyrcHelper.shareLyrcHelper.setSongLyrcWithUrl((playModel?.lrclink)!)
        timeArray = result.0
        lyricArray = result.1
        lyricTableView.reloadData()
        backImageV.sd_setImageWithURL(NSURL(string: (playModel?.pic_radio)!), placeholderImage: UIImage(named: "3.jpg"))
    }
    
//    更改歌曲
    func replaceItemWithIndex(index:NSInteger){
        let model:SongModel = MusicPlayer.shareMusicPlayer.songModels![index]
        musicTitle.text = model.title
        authorLabel.text = model.author
        let playModel = MusicPlayer.shareMusicPlayer.playModel
        let result = LyrcHelper.shareLyrcHelper.setSongLyrcWithUrl((playModel?.lrclink)!)
        timeArray = result.0
        lyricArray = result.1
        lyricTableView.reloadData()
        backImageV.sd_setImageWithURL(NSURL(string: (playModel?.pic_radio)!), placeholderImage: UIImage(named: "3.jpg"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension CommonMusicPlayController:UITableViewDelegate, UITableViewDataSource {
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if (cell == nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = lyricArray[indexPath.row ] as String
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25
    }
}