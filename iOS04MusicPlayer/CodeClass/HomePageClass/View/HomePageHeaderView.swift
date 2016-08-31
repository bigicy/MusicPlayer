//
//  HomePageHeaderView.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/25.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class HomePageHeaderView: UIScrollView {
    
    init(frame: CGRect, imageModels:[HomePagePicModel], tapAction:Selector, timeInterval:NSTimeInterval, timeAction:Selector, target:AnyObject) {
        super.init(frame: frame)
        // 遍历数据模型创建imageView， 以及设置相关的点击事件
        let width = frame.size.width
        let height = frame.size.height
        for (index, imageModel) in imageModels.enumerate() {
            let imageView = UIImageView(frame:CGRectMake(CGFloat(index)*width, 0, width, height))
            imageView.userInteractionEnabled = true
//            给imageView添加手势
            let tap = UITapGestureRecognizer(target: target, action: tapAction)
            imageView.addGestureRecognizer(tap)
            imageView.sd_setImageWithURL(NSURL(string:imageModel.randpic_iphone6!))
            addSubview(imageView)
        }
        contentSize = CGSizeMake(CGFloat(imageModels.count)*width, height)
        pagingEnabled = true
        bounces = false
        NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: target, selector: timeAction, userInfo: self, repeats: true)
    }
//    加载xib的时候调用
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
