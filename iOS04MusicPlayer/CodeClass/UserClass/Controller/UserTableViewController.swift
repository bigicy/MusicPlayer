//
//  UserTableViewController.swift
//  iOS04MusicPlayer
//
//  Created by SZT on 16/7/22.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    lazy var dataArray:[String] = {
        let dataArray = [String]()
        return dataArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = ["历史记录", "下载列表", "播放列表", "设置"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UserTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let historyVC = HistoryRecordsController()
            navigationController?.pushViewController(historyVC, animated: true)
        }else if indexPath.row == 1{
            let downloadVC = DownLoadListController()
            navigationController?.pushViewController(downloadVC, animated: true)
        }else if indexPath.row == 2{
            let playListVC = PlayListController()
            navigationController?.pushViewController(playListVC, animated: true)
        }else{
            let setupVC = SetupController()
            navigationController?.pushViewController(setupVC, animated: true)
        }
    }
}



