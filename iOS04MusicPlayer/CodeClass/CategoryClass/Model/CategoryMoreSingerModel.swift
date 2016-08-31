//
//  CategoryMoreSingerModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/29.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryMoreSingerModel: NSObject {
    
    var title: String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
}
