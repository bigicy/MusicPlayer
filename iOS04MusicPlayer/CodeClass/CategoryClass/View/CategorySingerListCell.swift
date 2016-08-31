//
//  CategorySingerListCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/30.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategorySingerListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var imageV: UIImageView!

    @IBOutlet weak var authorLabel: UILabel!
    
    func setValueWithModel(model:CategorySingerListModel){
        imageV.sd_setImageWithURL(NSURL(string: model.avatar_big!))
        authorLabel.text = model.name
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
