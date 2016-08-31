//
//  CategoryActivityCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/27.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryActivityCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setValueWithModel(model:CategoryActivityModel){
        imageV.sd_setImageWithURL(NSURL(string: model.icon_android!))
        nameLabel.text = model.scene_name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
