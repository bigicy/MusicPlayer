//
//  TopMusicListModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/26.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class TopMusicListModel: NSObject {
    var content: NSArray?
    var comment: String?
    var count:Int = 4
    var name:String?
    var pic_s192: String?
    var pic_s210: String?
    var pic_s260: String?
    var pic_s444: String?
    var type = 0
    var web_url: String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    init(dict: [String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    
}
