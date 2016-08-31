//
//  CategoryHotSingerHeaderCell.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/27.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryHotSingerHeaderCell: UICollectionViewCell {

    var block:(() -> Void)?
    
    @IBAction func moreSingerBtn(sender: UIButton) {
        block!()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
