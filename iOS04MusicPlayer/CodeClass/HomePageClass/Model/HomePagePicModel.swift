//
//  HomePagePicModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/25.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class HomePagePicModel: NSObject {
    var randpic: String?
    var randpic_ios5: String?
    var randpic_desc:String?
    var randpic_ipad: String?
    var randpic_qq: String?
    var randpic_2: String?
    var randpic_iphone6: String?
    var special_type = 0
    var ipad_desc: String?
    var is_publish: String?
    var mo_type: String?
    var type = 0
    var code: String?
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
}
