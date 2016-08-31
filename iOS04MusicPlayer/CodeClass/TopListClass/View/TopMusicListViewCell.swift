//
//  TopMusicListViewCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/26.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class TopMusicListViewCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var firstMusic: UILabel!

    @IBOutlet weak var secondMusic: UILabel!
    
    @IBOutlet weak var thirdMusic: UILabel!
    
    @IBOutlet weak var fourthMusic: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    func setValueWithModel(topModel:TopMusicListModel){
        imageV.sd_setImageWithURL(NSURL(string: topModel.pic_s192!))
        nameLabel.text = topModel.name
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
