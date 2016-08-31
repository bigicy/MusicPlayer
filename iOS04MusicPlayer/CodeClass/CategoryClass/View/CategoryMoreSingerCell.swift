//
//  CategoryMoreSingerCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/29.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryMoreSingerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

        
    @IBOutlet weak var maleLabel: UILabel!
    
    
    func setValueWithModel(model:CategoryMoreSingerModel){
        maleLabel.text = model.title
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
