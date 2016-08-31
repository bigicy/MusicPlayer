//
//  DownLoadListController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/8/3.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit
import AVFoundation
class DownLoadListController: UITableViewController {
    
    lazy var dataArray:[NSString] = {
         var dataArray = [NSString]()
         return dataArray
    }()
    var filePath:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
     filePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        
      dataArray = MusicPlayerDownLoad.shareMusicPlayerDownLoad.musicArray
        print(dataArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DownLoadListController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataArray[indexPath.row] as String
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let string = (filePath! as String) + "/" + (dataArray[indexPath.row] as String)
        let path = NSBundle.mainBundle().pathForResource(string, ofType: nil)
        print(path)
        do {
          let player = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            player.play()
        }catch{
           print("歌曲播放错误")
        }
        
    }
}