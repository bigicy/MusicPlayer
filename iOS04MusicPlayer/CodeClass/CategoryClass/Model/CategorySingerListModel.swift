//
//  CategorySingerListModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/30.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategorySingerListModel: NSObject {

    var albums_total:String?
    var artist_id: String?
    var area: String?
    var avatar_big: String?
    var avatar_middle: String?
    var avatar_mini:String?
    var avatar_small:String?
    var country:String?
    var firstchar:String?
    var name:String?
    var songs_total: String?
    var ting_uid:String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    init(dict: [String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    /*
    "albums_total" = 9;
    area = 0;
    "artist_id" = 88;
    "avatar_big" = "http://musicdata.baidu.com/data2/pic/3ff5e1d37c04feb6d6bd3e6fe47f6c8b/246669446/246669446.jpg";
    "avatar_middle" = "http://musicdata.baidu.com/data2/pic/74312948b16e42bfa63e59994ec98981/246669450/246669450.jpg";
    "avatar_mini" = "http://musicdata.baidu.com/data2/pic/8779f839c9e01d78d1e1cf285ebda7fc/246669482/246669482.jpg";
    "avatar_small" = "http://musicdata.baidu.com/data2/pic/0f626d22f80c97139dde60f9dd914723/246669481/246669481.jpg";
    country = "\U4e2d\U56fd";
    firstchar = X;
    gender = 0;
    name = "\U859b\U4e4b\U8c26";
    "piao_id" = 0;
    "songs_total" = 92;
    "ting_uid" = 2517;
   */
}
