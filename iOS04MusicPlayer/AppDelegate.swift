//
//  AppDelegate.swift
//  iOS04MusicPlayer
//
//  Created by SZT on 16/7/22.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.rootViewController = BaseTabBarViewController()
        
        let session = AVAudioSession()
//        设置后台播放歌曲权限
        do{
           try session.setCategory(AVAudioSessionCategoryPlayback)
        }catch{
            print("error--session.setCategory(AVAudioSessionCategoryPlayback)")
        }
        do{
           try session.setActive(true)
        }catch{
            print("error--session.setActive(true)")
        }
//        开始接收用户操作事件
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
//        取消第一响应者
        resignFirstResponder()
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
//    接收到远程控制事件的时候调用该方法
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
//        subtype  类型   rawValue : 关联值
        switch event!.subtype.rawValue {
//            播放
        case UIEventSubtype.RemoteControlPlay.rawValue:
            MusicPlayer.shareMusicPlayer.startPlayMusic()
//            停止
        case UIEventSubtype.RemoteControlPause.rawValue:
            MusicPlayer.shareMusicPlayer.stopPlayMusic()
//            上一首
        case UIEventSubtype.RemoteControlPreviousTrack.rawValue:
            MusicPlayer.shareMusicPlayer.playPreviousMusic()
//            下一首
        case UIEventSubtype.RemoteControlNextTrack.rawValue:
            MusicPlayer.shareMusicPlayer.playNextMusic()
        default:
            print("default")
        }
    }

    func applicationWillResignActive(application: UIApplication) {
       
    }

    func applicationDidEnterBackground(application: UIApplication) {
      
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }
// 后台进入到前台  应用程序进入活跃状态下调用
    func applicationDidBecomeActive(application: UIApplication) {
//        开始接收远程控制事件
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
//        成为第一响应者
        becomeFirstResponder()
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }


}

