//
//  HomePageRecommendModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/25.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class HomePageRecommendModel: NSObject {
   
    var listid: String?
    var pic: String?
    var listenum: String?
    var collectnum: String?
    var title: String?
    var tag: String?
    var type: String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
 /*
    {
    "error_code": 22000,
    "content": {
    "title": "热门歌单",
    "list": [
    {
    "listid": "6871",
    "pic": "http://business.cdn.qianqian.com/qianqian/pic/bos_client_6e409fa7e80c7cff62212b880056ab1c.jpg",
    "listenum": "629",
    "collectnum": "405",
    "title": "饮下一杯伤感，祝我幸福",
    "tag": "悲伤,休息",
    "type": "gedan"
    },
    {
    "listid": "6870",
    "pic": "http://business.cdn.qianqian.com/qianqian/pic/bos_client_45afa606569cfa3c10c12f38eac5c809.jpg",
    "listenum": "430",
    "collectnum": "437",
    "title": "朋克摇滚，拼命生活的态度",
    "tag": "朋克,兴奋,摇滚",
    "type": "gedan"
    },
    {
    "listid": "6867",
    "pic": "http://business.cdn.qianqian.com/qianqian/pic/bos_client_f1c840a1bd9577dd9fb1bb44a501cee6.jpg",
    "listenum": "569",
    "collectnum": "420",
    "title": "燃！这些激动人心的声音",
    "tag": "日语,兴奋",
    "type": "gedan"
    },
    {
    "listid": "6868",
    "pic": "http://business.cdn.qianqian.com/qianqian/pic/bos_client_91c0ac1207ab5bfa00aa9aeac90f2943.jpg",
    "listenum": "386",
    "collectnum": "441",
    "title": "萌萌哒~儿童歌曲致童年",
    "tag": "儿歌,快乐,经典",
    "type": "gedan"
    }
    ]
    }
    }
  */
}
