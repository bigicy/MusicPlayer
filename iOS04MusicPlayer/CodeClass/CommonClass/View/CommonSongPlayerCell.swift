//
//  CommonSongPlayerCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/28.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CommonSongPlayerCell: UITableViewCell {

    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValueWithModel(model: SongModel){
        titleLabel.text = model.title
        authorLabel.text = model.author
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
