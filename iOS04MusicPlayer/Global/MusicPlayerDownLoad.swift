//
//  MusicPlayerDownLoad.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/8/1.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit



class MusicPlayerDownLoad: NSObject{
    
    var session:NSURLSession?
    
    lazy var musicArray:[NSString] = {
         let musicArray = [NSString]()
         return musicArray
    }()
    
    static var shareMusicPlayerDownLoad:MusicPlayerDownLoad = {
       let instance = MusicPlayerDownLoad()
        instance.session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: instance, delegateQueue: NSOperationQueue.mainQueue())
       return instance
    }()
    
    func creatDownLoadTask(playModel:PlayModel){
        
        let downloadTask = session?.downloadTaskWithURL(NSURL(string: playModel.file_link!)!)
        downloadTask?.resume()
    }
}

extension MusicPlayerDownLoad:NSURLSessionDelegate, NSURLSessionDownloadDelegate{
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL)
    {
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath = cachePath.stringByAppendingString("/\(downloadTask.response!.suggestedFilename!)")
        print(filePath)
        musicArray.append((downloadTask.response?.suggestedFilename)!)
        let fileManager = NSFileManager.defaultManager()
        do{
            try fileManager.moveItemAtPath(location.path!, toPath: filePath)
        }catch{
            print("移动文件夹出错")
        }
    }
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
    {
        let progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        print(progress)
        if progress == 1.0 {
            print("下载成功")
        }
    }
}
