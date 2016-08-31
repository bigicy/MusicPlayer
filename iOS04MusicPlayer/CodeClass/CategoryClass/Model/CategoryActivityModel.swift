//
//  CategoryActivityModel.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/27.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryActivityModel: NSObject {
    
    var bgpic_android: String?
    var bgpic_ios:String?
    var icon_android:String?
    var icon_ios: String?
    var scene_desc:String?
    var scene_id:String?
    var scene_model: Int = 2
    var scene_name: String?
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    /*
 {
 "bgpic_android" = "";
 "bgpic_ios" = "";
 "icon_android" = "http://c.hiphotos.baidu.com/ting/pic/item/b999a9014c086e06604a914805087bf40bd1cbd7.jpg";
 "icon_ios" = "http://b.hiphotos.baidu.com/ting/pic/item/94cad1c8a786c917cd5a64c9cf3d70cf3ac757e0.jpg";
 "scene_desc" = "";
 "scene_id" = 0;
 "scene_model" = 2;
 "scene_name" = "\U5728\U8def\U4e0a";
 },
*/

}
