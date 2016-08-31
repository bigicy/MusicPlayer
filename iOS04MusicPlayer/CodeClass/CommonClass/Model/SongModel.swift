//
//  SongModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/28.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class SongModel: NSObject {
    
    var album_id:String?
    var album_title:String?
    var all_artist_id:String?
    var all_rate:String?
    var author:String?
    var title:String?
    var song_id:String?
    var ting_uid:String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

}
