//
//  PlayListController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/8/3.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class PlayListController: UITableViewController {
    lazy var playArray:[PlayModel] = {
        let playArray = [PlayModel]()
        return playArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        playArray = MusicPlayerDataBase.shareMusicDataBase.selectAllModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PlayListController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("playCell")
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: "playCell")
        }
        let model = playArray[indexPath.row]
        cell?.textLabel?.text = model.title
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let musicPlayVC = CommonMusicPlayController()
        navigationController?.pushViewController(musicPlayVC, animated: true)
    }
}