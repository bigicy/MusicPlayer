//
//  PlayModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/28.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class PlayModel: NSObject {
    var file_link:String?
    var file_duration = 0
    var show_link:String?
    var aliasname:String?
    var album_id:String?
    var album_title:String?
    var artist_id:String?
    var author:String?
    var lrclink:String?
    var pic_radio:String?
    var song_id:String?
    var ting_uid:String?
    var title:String?
    
    init(songinfo:[String:AnyObject],songurl:[String:AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(songinfo)
        setValuesForKeysWithDictionary(songurl)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override init() {
        super.init()
    }
}
