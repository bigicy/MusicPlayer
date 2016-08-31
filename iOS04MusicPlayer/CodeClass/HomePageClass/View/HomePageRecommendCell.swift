//
//  HomePageRecommendCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/25.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class HomePageRecommendCell: UITableViewCell {

    @IBOutlet weak var homePageScrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setImageArray(recommandModels:[HomePageRecommendModel], target:AnyObject, action: Selector){
        let width = (screenWidth - 60)/2
        let height = width
        for (index,model) in recommandModels.enumerate(){
            let imageView = UIImageView (frame: CGRectMake(15+CGFloat(index)*screenWidth/2, 10, width, height))
            let tap = UITapGestureRecognizer(target: target, action: action)
            imageView.addGestureRecognizer(tap)
            imageView.tag = index + 1
            imageView.userInteractionEnabled = true
            imageView.layer.cornerRadius = width/2
            imageView.layer.masksToBounds = true
            imageView.sd_setImageWithURL(NSURL(string: model.pic!))
            let label = UILabel(frame: CGRectMake(15+CGFloat(index)*screenWidth/2, 15+height, width,30))
            label.text = model.title
            label.textColor = UIColor.whiteColor()
            homePageScrollView.addSubview(label)
            homePageScrollView.addSubview(imageView)
        }
        homePageScrollView.contentSize = CGSizeMake(2*screenWidth, 0)
        homePageScrollView.pagingEnabled = true
        homePageScrollView.bounces = false
    }
}
