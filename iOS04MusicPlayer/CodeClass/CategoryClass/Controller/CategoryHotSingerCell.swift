//
//  CategoryHotSingerCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/27.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryHotSingerCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setValueWithModel(model:CategoryHotSingerModel){
        imageV.sd_setImageWithURL(NSURL(string: model.avatar_big!))
        imageV.layer.cornerRadius = imageV.frame.size.width/2
        imageV.layer.masksToBounds = true
        nameLabel.text = model.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
