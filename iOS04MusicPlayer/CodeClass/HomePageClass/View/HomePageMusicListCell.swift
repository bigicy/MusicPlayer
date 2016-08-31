//
//  HomePageMusicListCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/25.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class HomePageMusicListCell: UITableViewCell {

    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValueWithModel(model:HomePageMusicListModel){
            imageV.sd_setImageWithURL(NSURL(string: model.pic_300!))
            imageV.layer.cornerRadius = imageV.frame.size.width/2
            imageV.layer.masksToBounds = true
            firstLabel.text = model.title
            secondLabel.text = model.desc
            thirdLabel.text = model.listenum
    }
    
    // 赋值操作
    var hotListModel:HomePageMusicListModel?{
//        set方法赋值操作
        didSet{
            imageV.sd_setImageWithURL((NSURL(string:(hotListModel?.pic_300)!)))
            firstLabel.text = hotListModel?.title
            secondLabel.text = hotListModel?.desc
            thirdLabel.text = hotListModel?.listenum
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
